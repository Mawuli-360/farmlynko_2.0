import 'package:farmlynko/feature/authentication/buyer_registration.dart';
import 'package:farmlynko/feature/authentication/farmer_registration.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreen())),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            )),
      ),
      body: Container(
        width: double.infinity,
        height: 100.h,
        color: AppColors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(10.h),
              Image(
                height: 20.h,
                width: 20.h,
                image: AppImages.logo,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.1.h),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Welcome to ",
                      style: AppTextStyle.latoStyle(
                          size: 14,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(148, 0, 0, 0)),
                      children: const [
                        TextSpan(
                          text: "Farmlynco",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              " the revolutionary app bridging the gap between farmers and buyers!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ),
              Gap(4.h),
              Text(
                "Are you here as a Buyer or Farmer?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: AppColors.primaryColor),
              ),
              Gap(4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.w,
                    height: 6.h,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const BuyerRegisterScreen()));
                        },
                        child: Text(
                          "Buyer",
                          style: TextStyle(fontSize: 13.sp),
                        )),
                  ),
                  Gap(4.h),
                  SizedBox(
                    width: 30.w,
                    height: 6.h,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const FarmerRegisterScreen()));
                        },
                        child: Text(
                          "Farmer",
                          style: TextStyle(fontSize: 13.sp),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
