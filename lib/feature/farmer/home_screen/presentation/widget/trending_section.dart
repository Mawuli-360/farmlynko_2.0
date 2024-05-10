import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.h),
          child: Text(
            'Trending',
            style:
                AppTextStyle.latoStyle(size: 16, color: AppColors.primaryColor),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
          width: double.infinity,
          height: 183,
          decoration: const BoxDecoration(),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 80.w,
                height: 10.h,
                margin: EdgeInsets.only(right: 2.h, left: 2.h),
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.green),
                    color: const Color(0xffD0FFE3),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Up to 30% offer!',
                              style: AppTextStyle.latoStyle(
                                  size: 14, color: const Color(0xff008B38))),
                          Gap(2.h),
                          Text('Try the new lawn food\nto boost productivity',
                              style: AppTextStyle.latoStyle(
                                  size: 10, color: AppColors.darkGrey)),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/images/fert.png',
                        width: 127,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 90.w,
                height: 10.h,
                margin: EdgeInsets.only(right: 4.h),
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                    color: const Color(0xffFFF8D0),
                    border: Border.all(color: AppColors.green),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Up to 20% offer!',
                              style: AppTextStyle.latoStyle(
                                  size: 14, color: const Color(0xff008B38))),
                          Gap(1.5.h),
                          Text(
                              'Exclusive offer on Innovative Farm Tool Boost Your Harvest T0day',
                              style: AppTextStyle.latoStyle(
                                  size: 10, color: AppColors.darkGrey)),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/images/fork.png',
                        width: 127,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
