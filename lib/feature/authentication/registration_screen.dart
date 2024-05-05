import 'package:farmlynko/feature/authentication/buyer_registration.dart';
import 'package:farmlynko/feature/authentication/farmer_registration.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
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
      body: Container(
        width: double.infinity,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Gap(2.h),
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
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 30.w,
                  height: 6.h,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FarmerRegisterScreen()));
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
    );
  }
}
