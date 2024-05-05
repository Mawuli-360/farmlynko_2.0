
import 'package:farmlynko/shared/data/home_data.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.green)),
              child: Center(
                child: AppImages.back,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            width: 4.3.h,
            margin: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(image: AppImages.avatar),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          )
        ],
        centerTitle: true,
        title: Text(
          "Payment Method",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Please Select Your Payment Method",
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(
              height: 0.2.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              height: 60.h,
              child: ListView.builder(
                  itemCount: HomeData.paymentData(context: context).length,
                  itemBuilder: (context, index) => _buildPaymentMethod(
                      text: HomeData.paymentData(context: context)[index].text,
                      onTap:
                          HomeData.paymentData(context: context)[index].onTap)),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
      {required String text, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 6.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
