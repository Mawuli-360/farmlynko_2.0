import 'dart:io';

import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final categoryProvider = StateProvider<String>((ref) {
  return 'Fruit';
});

class FarmerAddProductScreen extends ConsumerStatefulWidget {
  const FarmerAddProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerAddProductScreenState();
}

class _FarmerAddProductScreenState
    extends ConsumerState<FarmerAddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  String imageUrl = "";

  Future<void> addProductToFirestore() async {
    final firestore = ref.watch(firebaseFirestoreProvider);
    final auth = ref.watch(firebaseAuthProvider);
    if (productDescriptionController.text.isNotEmpty &&
        productNameController.text.isNotEmpty &&
        productPriceController.text.isNotEmpty &&
        imageUrl.isNotEmpty) {
      final currentUserID = auth.currentUser!.uid;
      final category = ref.watch(categoryProvider.notifier).state;
      final productId = const Uuid().v4();
      final productData = {
        'id': productId,
        'category': category,
        'image': imageUrl,
        'name': productNameController.text,
        'price': productPriceController.text,
        'description': productDescriptionController.text,
        'userId': currentUserID,
      };

    await firestore.collection('products').doc(productId).set(productData);
      Fluttertoast.showToast(msg: "Product added successfully");
      productDescriptionController.clear();
      productNameController.clear();
      productPriceController.clear();
      imageUrl = "";
    } else {
      Fluttertoast.showToast(msg: "Please fill in all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryProvider.notifier).state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[200],
        title: const Text("Farmer Add Product"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        color: Colors.amber[200],
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Farmer Registration"),
                TextFormField(
                    controller: productNameController,
                    decoration: const InputDecoration(
                        hintText: "product name",
                        border: OutlineInputBorder())),
                TextFormField(
                    controller: productPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "product price",
                        border: OutlineInputBorder())),
                TextFormField(
                    controller: productDescriptionController,
                    decoration: const InputDecoration(
                        hintText: "product description",
                        border: OutlineInputBorder())),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: 300,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text("upload image")),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(
                                source: ImageSource.camera);

                            if (file == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('product_images');

                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);

                            try {
                              await referenceImageToUpload
                                  .putFile(File(file.path));
                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                            } catch (error) {
                              //   //Some error occurred
                            }
                          },
                          child: const Text("Take picture")),
                    ],
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: category,
                  onChanged: (value) {
                    ref.read(categoryProvider.notifier).state = value!;
                  },
                  items: ['Fruit', 'Vegetables', 'Grain'].map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      addProductToFirestore();
                    },
                    child: const Text("add product")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
