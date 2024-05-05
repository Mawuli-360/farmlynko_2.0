
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 15.h,
            child: const Image(image: AppImages.handshake),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "Thank You For Your Purchase",
            style: TextStyle(fontSize: 18.sp),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "Order #123RG231567Y Confirmed",
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(
            height: 13.h,
          ),
          CustomButton(
              title: "Go To My Order",
              onTap: () {
                Navigation.openorderScreen(context: context);
              }),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: Text(
                "Go To Home",
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ))
        ]),
      ),
    );
  }
}
