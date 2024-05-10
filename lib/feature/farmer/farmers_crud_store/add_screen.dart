import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

final isAddingProduct = StateProvider<bool>((ref) => false);

class FarmAddScreen extends ConsumerStatefulWidget {
  const FarmAddScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FarmAddScreenState();
}

class _FarmAddScreenState extends ConsumerState<FarmAddScreen> {
  File? _imageFile;

  Future<void> _pickImage(BuildContext context) async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
        ],
      ),
    );

    if (imageSource != null) {
      final imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(() {
          _imageFile = File(file.path);
        });
      }
    }
  }

  Future<void> _uploadProduct() async {
    if (_imageFile == null) return;

    ref.read(isAddingProduct.notifier).state = true;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images_product');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(_imageFile!);
      String imageUrl = await referenceImageToUpload.getDownloadURL();
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('${FirebaseAuth.instance.currentUser?.uid}')
          .get();

      // Upload product data to Cloud Firestore
      final productData = {
        'name': productNameController.text,
        'description': descriptionController.text,
        'price': priceController.text,
        'userId': '${FirebaseAuth.instance.currentUser?.uid}',
        'userPhoneNumber': '${userDoc.data()!['phoneNumber']}',
        'profilePic': '${userDoc.data()!['imageUrl']}',
        'productOwner': '${userDoc.data()!['fullName']}',
        'imageUrl': imageUrl,
      };

      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('products')
          .add(productData);
      String productId = docRef.id;

      // Update the productId field with the document ID
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({'productId': productId});

      showToast(context, "Product added successfully");

      ref.read(isAddingProduct.notifier).state = false;

      setState(() {
        productNameController.clear();
        priceController.clear();
        descriptionController.clear();
        _imageFile = null;
      });

      Navigator.pop(context);
    } catch (error) {
      // Handle the error
      ref.read(isAddingProduct.notifier).state = false;
    }
  }

  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Product',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: const BoxDecoration(),
        child: ListView(
          children: [
            Gap(4.h),
            GestureDetector(
                onTap: () => _pickImage(context),
                child: _imageFile == null
                    ? Container(
                        width: double.infinity,
                        height: 157,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 61, 170, 152),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 12.h,
                            width: 12.h,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.camera,
                                size: 5.h,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          SizedBox(
                            width: 64.w,
                            height: 24.h,
                          ),
                          Positioned(
                            top: 1.h,
                            left: 1.h,
                            child: Container(
                              width: 60.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_imageFile!),
                                    fit: BoxFit.fill),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _pickImage(context),
                            child: CircleAvatar(
                              radius: 2.5.h,
                              backgroundColor: AppColors.primaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.edit,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
            Gap(3.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 20, 8, 0),
                    child: TextFormField(
                      controller: productNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Name',
                      ),
                      obscureText: false,
                    ),
                  ),
                  Gap(2.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: TextFormField(
                            controller: priceController,
                            decoration: const InputDecoration(
                                labelText: 'Price',
                                border: OutlineInputBorder()),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: TextFormField(
                            obscureText: false,
                            readOnly: true,
                            decoration: const InputDecoration(
                                hintText: "/bag",
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.grey)),
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(2.h),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ),
            ref.watch(isAddingProduct)
                ? const Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: () async {
                      if (productNameController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        showToast(context, "Fields are compulsory to filled");
                      }
                      _uploadProduct();
                    },
                    child: Container(
                      width: 40.h,
                      height: 6.h,
                      decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppColors.primaryColor),
                      child: Center(
                        child: Text(
                          "Add Product",
                          style: AppTextStyle.latoStyle(
                              size: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
