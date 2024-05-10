import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 1.5.h, right: 1.5.h, top: 1.2.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 280,
                  color: Colors.yellow,
                  child: Stack(
                    children: [
                      Container(color: Colors.white),
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AppImages.manchat, fit: BoxFit.fill),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(1.h),
                            height: 4.h,
                            width: 4.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1.h))),
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.7.h),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 2.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  height: 20.h,
                                  width: 20.h,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AppImages.logo)),
                                ),
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Farmlynco",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                const Text("www.farmlynco.com"),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Send Your Doubt Here\nWe will get back to you",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Your message",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ],
            ),
          ),
        )),
        bottomNavigationBar: CustomButton(
          title: "Submit",
          onTap: () {
            Navigation.openreportAppreciationScreen(context: context);
          },
        ));
  }
}
