import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/authentication/registration_screen.dart';
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/sign_up_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/service/auth_service.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final bool _isLoading = false;
  String selectedRole = "Farmer";

  void _handleAuthentication(String selectedRole) async {
    bool isAuthSuccessful =
        await AuthService.authenticateUser(selectedRole, ref, context);

    if (isAuthSuccessful) {
      // Authentication successful
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        // User is authenticated and the selected role matches
        String uid = currentUser.uid;
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(uid).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          String role = userData['role'];

          if (role == 'Buyer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (role == 'Farmer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FarmerMainScreen()),
            );
          }
        } else {
          // User document not found in Firestore
          showToast(context, 'User document not found');
        }
      } else {
        // User is not authenticated or the selected role doesn't match
        showToast(context, 'Authentication failed');
      }
    } else {
      // Authentication failed
      showToast(context, 'Authentication failed');
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
                child: const Text(
                  "YES",
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: 100.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    _buildTextField(
                        title: 'E-mail',
                        hintText: 'eg. alexduncan@gmail.com',
                        onChanged: (value) {
                          ref.read(emailProvider.notifier).state = value;
                        }),
                    _buildTextField(
                        title: 'password',
                        hintText: '',
                        onChanged: (value) {
                          ref.read(passwordProvider.notifier).state = value;
                        }),
                    SizedBox(
                      width: double.infinity,
                      height: 28.h,
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
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Farmer",
                                    groupValue: selectedRole,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRole = value!;
                                      });
                                    },
                                  ),
                                  const Text('Farmer'),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Buyer",
                                    groupValue: selectedRole,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRole = value!;
                                      });
                                    },
                                  ),
                                  const Text('Buyer'),
                                ],
                              ),
                            ],
                          ),
                          Gap(1.h),
                          GestureDetector(
                            onTap: () async {
                              if (ref
                                      .read(emailProvider.notifier)
                                      .state
                                      .isEmpty &&
                                  ref
                                      .read(passwordProvider.notifier)
                                      .state
                                      .isEmpty) {
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Missing Information'),
                                      content: const Text(
                                          'Please fill in all fields.'),
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
                              }
                              // setState(() {
                              //   _isLoading = true;
                              // });
                              // AuthService.authenticateUser(
                              //     selectedRole, ref, context);
                              _handleAuthentication(selectedRole);
                            },
                            child: ref.watch(isLoading)
                                ? SizedBox(
                                    height: 3.h,
                                    width: double.infinity,
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    )))
                                : Container(
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
                                      "LOGIN",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    )),
                                  ),
                          ),
                          Gap(2.h),
                          SizedBox(
                            width: 100.w,
                            height: 4.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegistrationScreen()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                    ),
                                    // style: ButtonStyle(padding: MaterialStateProperty),
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 12.sp),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 0.05.h,
                            color: Colors.grey,
                            width: 15.h,
                          ),
                          const Text("Sign in with"),
                          Container(
                            height: 0.05.h,
                            color: Colors.grey,
                            width: 15.h,
                          ),
                        ],
                      ),
                    ),
                    Gap(3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.h),
                            height: 60,
                            width: 20.h,
                            decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                      color: const Color.fromARGB(
                                          57, 102, 101, 99),
                                      spreadRadius: 0.1.h,
                                      blurRadius: 3.h,
                                      offset: const Offset(10, 10))
                                ],
                                color: Colors.white,
                                shape: const StadiumBorder()),
                            child: Row(
                              children: [
                                AppImages.facebook,
                                SizedBox(
                                  width: 1.h,
                                ),
                                const Text(
                                  "FACEBOOK",
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(horizontal: 2.h),
                            width: 20.h,
                            decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                      color: const Color.fromARGB(
                                          57, 102, 101, 99),
                                      spreadRadius: 0.1.h,
                                      blurRadius: 3.h,
                                      offset: const Offset(10, 10))
                                ],
                                color: Colors.white,
                                shape: const StadiumBorder()),
                            child: Row(
                              children: [
                                AppImages.google,
                                SizedBox(
                                  width: 1.h,
                                ),
                                const Text(
                                  "GOOGLE",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
      required void Function(String) onChanged}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      height: 100,
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
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
        ],
      ),
    );
  }
}
