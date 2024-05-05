import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Details',
                  style:
                      AppTextStyle.latoStyle(size: 14, color: AppColors.green),
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 20.h,
          margin: EdgeInsets.only(right: 2.h, left: 2.h, bottom: 5.h),
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
                    Text('Today',
                        style: AppTextStyle.latoStyle(
                            size: 15, color: Colors.red)),
                    Gap(2.h),
                    Text('Chance of rain',
                        style: AppTextStyle.latoStyle(
                            size: 14, color: AppColors.darkGrey)),
                    Text('No need of umbrella',
                        style: AppTextStyle.latoStyle(
                            size: 12, color: AppColors.darkGrey)),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  'assets/images/r.png',
                  width: 127,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
