import 'dart:io';

import 'package:farmlynko/feature/authentication/email_verification_screen.dart';
import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/service/auth_service.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class FarmerRegisterScreen extends ConsumerStatefulWidget {
  const FarmerRegisterScreen({super.key});

  @override
  ConsumerState<FarmerRegisterScreen> createState() =>
      _FarmerRegisterScreenState();
}

class _FarmerRegisterScreenState extends ConsumerState<FarmerRegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

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

  void signUpFarmer() async {
    final firstName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phoneNumber = phoneController.text.trim();
    final firestore = ref.watch(firebaseFirestoreProvider);
    final auth = ref.watch(firebaseAuthProvider);

    if (firstName.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty ||
        _imageFile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Missing Information'),
            content: const Text('Please fill in all fields.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('farmers_profile');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(_imageFile!);
      String imageUrl = await referenceImageToUpload.getDownloadURL();

      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      final userRecord = {
        'uid': user!.uid,
        'fullName': firstName,
        'email': email,
        'phoneNumber': phoneNumber,
        'role': "Farmer",
        'imageUrl': imageUrl,
      };

      await firestore.collection('users').doc(user.uid).set(userRecord);

      await user.sendEmailVerification();

      final currentUser = auth.currentUser;

      Fluttertoast.showToast(
          msg: "user created successfully, please verify your email.");

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => EmailVerificationScreen(
                    user: currentUser!,
                  )));
      ref.watch(isFarmerSigningUp.notifier).state = false;

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      ref.watch(isFarmerSigningUp.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("NO"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: const Text("YES"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Farmer Sign Up",
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    _buildTextField(
                        title: 'Full name',
                        hintText: '',
                        onChanged: (value) {
                          fullNameController.text = value;
                        },
                        controller: fullNameController),
                    _buildTextField(
                        title: 'E-mail',
                        hintText: 'eg. alexduncan@gmail.com',
                        onChanged: (value) {
                          emailController.text = value;
                        },
                        controller: emailController),
                    _buildTextField(
                        title: 'Phone Number',
                        hintText: '054xxxxxxx',
                        textInputType: const TextInputType.numberWithOptions(),
                        onChanged: (value) {
                          phoneController.text = value;
                        },
                        controller: phoneController),
                    _buildTextField(
                        title: 'password',
                        hintText: '',
                        onChanged: (value) {
                          passwordController.text = value;
                        },
                        controller: passwordController),
                    Text(
                      "Upload your profile picture",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
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
                                        color: Colors.white,
                                        shape: BoxShape.circle),
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
                    SizedBox(
                      width: double.infinity,
                      height: 21.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          ref.watch(isFarmerSigningUp)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    ref
                                        .watch(isFarmerSigningUp.notifier)
                                        .state = true;

                                    signUpFarmer();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: 1.h, left: 4.h, right: 4.h),
                                    height: 6.h,
                                    decoration: ShapeDecoration(
                                        shadows: [
                                          BoxShadow(
                                              color: const Color.fromARGB(
                                                  57, 102, 101, 99),
                                              spreadRadius: 0.1.h,
                                              blurRadius: 3.h,
                                              offset: const Offset(10, 10))
                                        ],
                                        color: Colors.green,
                                        shape: const StadiumBorder()),
                                    child: Center(
                                        child: Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13.sp),
                                    )),
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 12.sp),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(1.5.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String title,
      required String hintText,
      required void Function(String) onChanged,
      required TextEditingController controller,
      TextInputType? textInputType}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      height: 12.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          SizedBox(
            height: 6.h,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: textInputType,
              decoration: InputDecoration(
                  hintText: hintText,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
        ],
      ),
    );
  }
}
