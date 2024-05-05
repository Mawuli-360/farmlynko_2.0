import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class IotScreen extends ConsumerWidget {
  const IotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'IoT Monitoring',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 30.h,
                width: 30.h,
                child: Lottie.asset("assets/animation/coming_soon.json")),
            Gap(3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.5.h),
              child: Text(
                "We are in the process of developing the IoT monitoring section as an upcoming feature",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp),
              ),
            ),
            Gap(5.h),
          ],
        ),
      ),
    );
  }
}
