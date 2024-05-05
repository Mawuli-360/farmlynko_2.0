import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/service/auth_service.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
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
        password.isEmpty) {
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

    try {
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
        'status': "pending",
      };

      await firestore.collection('users').doc(user.uid).set(userRecord);

      Fluttertoast.showToast(msg: "user created successfully");

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(uid).get();

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;

          if (userData['status'] == 'pending') {
            Navigation.navigateTo(Navigation.waitingScreen);
          }

          if (userData['status'] == 'approved') {
            Navigation.navigateTo(Navigation.farmerScreen);
          }
        }
      }

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
                    SizedBox(
                      width: double.infinity,
                      height: 21.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigation.openResetScreen(context: context);
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.green),
                              )),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
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
                                    color: Colors.white, fontSize: 12.sp),
                              )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.green),
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
      height: 10.h,
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
