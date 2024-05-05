import 'package:farmlynko/shared/data/service_data.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:farmlynko/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class ServiceLandingScreen extends ConsumerStatefulWidget {
  const ServiceLandingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ServiceLandingScreen> createState() =>
      _ServiceLandingScreenState();
}

class _ServiceLandingScreenState extends ConsumerState<ServiceLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: "Services",
        isTitleCentered: true,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Unlock a world of convenience with our ",
                      style: AppTextStyle.latoStyle(
                          size: 10,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(148, 0, 0, 0)),
                      children: [
                        TextSpan(
                          text: "Farmlynco ",
                          style: AppTextStyle.latoStyle(
                              size: 10,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(255, 4, 73, 35)),
                        ),
                        TextSpan(
                          text: "services, tailored to fit your needs",
                          style: AppTextStyle.latoStyle(
                              size: 10,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(148, 0, 0, 0)),
                        ),
                      ])),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h),
                child: MasonryGridView.builder(
                    itemCount: ServiceScreenData.services(context).length,
                    padding: EdgeInsets.zero,
                    crossAxisSpacing: 1.h,
                    mainAxisSpacing: 1.h,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ServiceCard(
                        ServiceScreenData.services(context)[index],
                        height: index % 2 == 0 ? 25.h : 20.h,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
