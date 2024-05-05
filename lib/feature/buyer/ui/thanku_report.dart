
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReportAppreciation extends StatelessWidget {
  const ReportAppreciation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(1.h),
            height: 2.h,
            width: 2.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(1.h))),
            child: Padding(
              padding: EdgeInsets.only(left: 0.7.h),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.green,
                size: 2.h,
              ),
            ),
          ),
        ),
      ),
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 20.h,
          child: const Center(
            child: Image(image: AppImages.logo),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          "Farmily",
          style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green),
        ),
        SizedBox(
          height: 18.h,
        ),
        Text(
          "Thanks, We WIll Rectify The\nProblem Very As Soon As\nPossible.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        )
      ]),
      bottomNavigationBar: CustomButton(
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        title: 'Go to Home',
      ),
    );
  }
}
