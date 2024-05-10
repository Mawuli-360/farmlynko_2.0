import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/service/auth_service.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      "Sign Up",
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
                          ref.read(nameProvider.notifier).state = value;
                        }),
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
                              AuthService.signUpWithEmailAndPassword(
                                  context: context, ref: ref);
                              // showToast(context, "Account successfully created");
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
                    SizedBox(
                      height: 2.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 0.05.h,
                            color: Colors.grey,
                            width: 15.h,
                          ),
                          const Text("Sign up with"),
                          Container(
                            height: 0.05.h,
                            color: Colors.grey,
                            width: 15.h,
                          ),
                        ],
                      ),
                    ),
                    Gap(1.5.h),
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
