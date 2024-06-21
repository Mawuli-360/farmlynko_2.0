import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TipSection extends StatelessWidget {
  const TipSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.h, bottom: 1.5.h),
          child: Text('Tips',
              style: AppTextStyle.latoStyle(
                  size: 16, color: AppColors.primaryColor)),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.h),
          padding: EdgeInsets.all(1.h),
          width: 377,
          height: 100,
          decoration: BoxDecoration(
              color: const Color(0xffD0FFE3),
              border: Border.all(color: Colors.green),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: Colors.amber,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Precision Irrigation',
                      style: AppTextStyle.latoStyle(size: 12),
                    ),
                    Text(
                      'Optimize water usage with precision\nirrigation systems, ensuring each plant\nreceives the right amount',
                      style: AppTextStyle.latoStyle(
                          size: 8.9, color: AppColors.darkGrey),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  'assets/images/garden.png',
                  width: 10.h,
                  height: 15.h,
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
