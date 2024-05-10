import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class WeatherSection extends ConsumerWidget {
  const WeatherSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(advice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Weather',
                  style: AppTextStyle.latoStyle(
                      size: 14, color: AppColors.primaryColor),
                ),
              ),
              TextButton(
                onPressed: () => _openAnimatedDialog(context, weather),
                child: Text(
                  'DETAILS',
                  style:
                      AppTextStyle.latoStyle(size: 14, color: AppColors.green),
                ),
              ),
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
                    Text(weather,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.latoStyle(
                            size: 12, color: AppColors.darkGrey)),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Lottie.asset(
                  'assets/animation/weather.json',
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

  void _openAnimatedDialog(BuildContext context, String weather) {
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
                          "Weather Tips",
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
                  weather,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ),
          );
        });
  }
}
