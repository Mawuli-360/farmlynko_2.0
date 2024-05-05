
import 'package:farmlynko/feature/buyer/provider/cart_provider.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/data/home_data.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class MobileMoney extends ConsumerWidget {
  const MobileMoney({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Network> networks = [
      Network('MTN'),
      Network('Vodafone'),
      Network('Tigo'),
      // Add more networks if needed
    ];
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
          " Mobile Money",
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
              "Add Your Payment Details",
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(
              height: 0.2.h,
            ),
            SizedBox(
              height: 8.h,
              child: const Image(image: AppImages.networks),
            ),
            SizedBox(
              height: 0.2.h,
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 3.h),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "Select Preferred Network:",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  DropdownButtonFormField<Network>(
                    items: networks
                        .map((network) => DropdownMenuItem<Network>(
                              value: network,
                              child: Text(network.name),
                            ))
                        .toList(),
                    onChanged: (selectedNetwork) {
                      // print(selectedNetwork!.name);
                    },
                    hint: const Text('Select Network'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10)
                    ], // Limit input to 10 characters
                    decoration: const InputDecoration(
                      hintText: 'Enter Telephone Number',
                    ),
                    onChanged: (phoneNumber) {
                      // print(phoneNumber);
                    },
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar: CustomButton(
        onTap: () {
          Navigation.opensuccessPaymentScreen(context: context);
          ref.read(cartProvider.notifier).clearCartAndSelectedAddOns(
              ref.read(selectedAddOnsProvider.notifier));
        },
        title: "Pay",
      ),
    );
  }
}
