import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(1.h),
            height: 2.h,
            width: 2.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(1.h))),
            child: Padding(
              padding: EdgeInsets.only(left: 0.7.h),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.green,
                size: 2.h,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(2.h),
        child: Text(
          "At Family, we prioritize your privacy and are committed to protecting your personal information. Our agricultural app provides access to markets, e-commerce, farming education, and expertise services. Here's a summary of our Privacy Policy:Personal Information:  Name, contact details, location, payment info (for services), device info,  and app interactions.How We Use Your Information:Service Provision: Facilitating app services.Communication: Sending updates and notifications.Analytics: Improving app performance.Sharing Your Information:Third-Party Providers: Trusted partners for app functions.Business Transfers: In case of mergers or acquisitions.Legal Requirements: Complying with the law.Data Security:Industry-standard measures to protect your data.Your Choices:Update personal information through app settings.Opt-out of promotional communications.Changes to Privacy Policy:Updated versions posted in the app.Contact Us: farmily@gmail.com | 0559093158",
          style: TextStyle(fontSize: 13.sp),
        ),
      ),
    );
  }
}
