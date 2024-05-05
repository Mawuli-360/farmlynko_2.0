import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:farmlynko/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Weather",
        isTitleCentered: true,
      ),
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primaryColor,
          ),
          Positioned(
            top: 4.h,
            child: Row(
              children: [
                Gap(2.h),
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 6.h,
                ),
                Gap(2.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Current Location:",
                      style: AppTextStyle.latoStyle(
                          size: 12, color: AppColors.white),
                    ),
                    Text(
                      "Tarkwa",
                      style: TextStyle(color: AppColors.white, fontSize: 12.sp),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 65.h,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(3.h))),
              child: const Column(
                children: [
                  Expanded(
                      child: Center(
                    child: Text("Weather Screen"),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
