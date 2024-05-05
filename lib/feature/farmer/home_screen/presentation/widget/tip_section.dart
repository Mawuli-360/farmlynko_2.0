import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        GestureDetector(
          onTap: () {
            _openAnimatedDialog(context);
          },
          child: Container(
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
        ),
      ],
    );
  }

  void _openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: AlertDialog(
                backgroundColor: const Color(0xffD0FFE3),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.green),
                    borderRadius: BorderRadius.circular(1.h)),
                contentPadding:
                    EdgeInsets.only(left: 1.5.h, right: 1.5.h, bottom: 1.5.h),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tips",
                          style: TextStyle(
                              color: AppColors.green, fontSize: 14.sp),
                        ),
                        Gap(1.h),
                        const Icon(
                          Icons.tips_and_updates,
                          color: Color.fromARGB(255, 200, 181, 18),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ))
                  ],
                ),
                content: Text(
                  "Optimize water usage with precision irrigation systems, ensuring each plant receives the right amount",
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ),
          );
        });
  }
}
