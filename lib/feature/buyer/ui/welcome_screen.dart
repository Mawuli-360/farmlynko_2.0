
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1613),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AppImages.bgimg, fit: BoxFit.fill)),
            ),
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AppImages.maskcolor, fit: BoxFit.fitWidth)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Welcome to",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Farmily",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    "Empowering farmers for a\nsustainable tomorrow",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 4.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 0.05.h,
                          color: Colors.grey,
                          width: 13.h,
                        ),
                        const Text(
                          "Sign in with",
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          height: 0.05.h,
                          color: Colors.grey,
                          width: 13.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.h),
                            height: 60,
                            width: 18.h,
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
                            width: 18.h,
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
                        )
                      ]),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigation.openSignUpScreen(context: context);
                    },
                    child: Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10.h)),
                        color: const Color.fromARGB(96, 255, 255, 255),
                      ),
                      child: const Center(
                          child: Text(
                        "Start with Email",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an acccount?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigation.openLoginScreen(context: context);
                          },
                          child: const Text(
                            "SignIn",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
