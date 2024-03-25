import 'package:farmlynko/main.dart';
import 'package:farmlynko/shared/resource/app_animation.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:farmlynko/shared/resource/social_launch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class FarmCommunity extends ConsumerStatefulWidget {
  const FarmCommunity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FarmCommunityState();
}

class _FarmCommunityState extends ConsumerState<FarmCommunity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Community',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to our vibrant farm community,\nwhere seeds of friendship and\ngrowth are sown daily",
              style: AppTextStyle.latoStyle(size: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40.h,
              child: Lottie.asset(AppAnimation.community),
            ),
            Gap(10.h),
            GestureDetector(
              onTap: () => SocialLaunch.launchTelegram(),
              child: Container(
                width: 60.w,
                height: 5.h,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: AppColors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Open Community",
                      style: AppTextStyle.latoStyle(
                          size: 12, color: AppColors.white),
                    ),
                    Gap(2.h),
                    const Icon(
                      Icons.send,
                      color: AppColors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
