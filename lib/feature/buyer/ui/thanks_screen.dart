
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ThankScreen extends StatelessWidget {
  const ThankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.red,
                  height: 40.h,
                ),
                const Image(image: AppImages.colormask),
                Positioned(
                  left: 14.h,
                  bottom: 18.h,
                  child: Image(
                    image: AppImages.thanku,
                    height: 22.h,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "Thanks Your Feedback Submitted",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            )
          ],
        )),
        bottomNavigationBar: CustomButton(
          onTap: () {
            Navigation.openHomeScreen(context: context);
          },
          title: 'Go to Home',
        ));
  }
}
