import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmlynko/main.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class FarmerHomeScreen extends ConsumerStatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends ConsumerState<FarmerHomeScreen> {
  CarouselController controller = CarouselController();
  int _current = 0;
  String selectedValue = "Crop Protection";
  String query = "";

  ClipRRect _buildCarouselItem(
      {required String title, required AssetImage image}) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: const ColorFilter.mode(
                  Color(0x52000000), BlendMode.colorBurn),
              image: image,
              fit: BoxFit.fill),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> newsItem = [
      _buildCarouselItem(
        title: "Farmer Associations call for PFJ audit",
        image: AppImages.planting,
      ),
      _buildCarouselItem(
        title:
            "Cocoa farmers in the Western region welcome\npension scheme project",
        image: AppImages.cocoafarmers,
      ),
      _buildCarouselItem(
        title: "How to successfully grow and harvest carrots",
        image: AppImages.carrotfarming,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title:
              Text("Welcome Albert", style: AppTextStyle.latoStyle(size: 15)),
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.segment_rounded,
                color: AppColors.black,
              ),
              onPressed: () {
                drawerController.toggle!();
              })),
      backgroundColor: AppColors.white,
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: AppColors.white),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    'Trending',
                    style: AppTextStyle.latoStyle(size: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                  width: double.infinity,
                  height: 183,
                  decoration: const BoxDecoration(),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 40.h,
                        height: 100,
                        margin: EdgeInsets.only(right: 2.h, left: 2.h),
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.green),
                            color: const Color(0xffD0FFE3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Up to 30% offer!',
                                      style: AppTextStyle.latoStyle(
                                          size: 14,
                                          color: const Color(0xff008B38))),
                                  Gap(2.h),
                                  Text(
                                      'Try the new lawn food\nto boost productivity',
                                      style: AppTextStyle.latoStyle(
                                          size: 10, color: AppColors.darkGrey)),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'assets/images/fert.png',
                                width: 127,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 377,
                        height: 40.h,
                        margin: EdgeInsets.only(right: 4.h),
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFF8D0),
                            border: Border.all(color: AppColors.green),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Up to 20% offer!',
                                      style: AppTextStyle.latoStyle(
                                          size: 14,
                                          color: const Color(0xff008B38))),
                                  Gap(2.h),
                                  Text(
                                      'Exclusive offer on\nInnovative Farm Tool\nBoost Your Harvest TOday',
                                      style: AppTextStyle.latoStyle(
                                          size: 10, color: AppColors.darkGrey)),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'assets/images/fork.png',
                                width: 127,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h, bottom: 1.5.h),
                  child: Text('Tips', style: AppTextStyle.latoStyle(size: 16)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.h),
                  padding: EdgeInsets.all(1.h),
                  width: 377,
                  height: 100,
                  decoration: BoxDecoration(
                      color: const Color(0xffD0FFE3),
                      border: Border.all(color: Colors.green),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
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
                                  size: 10, color: AppColors.darkGrey),
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
                Padding(
                  padding:
                      EdgeInsets.only(left: 2.h, bottom: 1.2.h, top: 1.5.h),
                  child: Text(
                    'News',
                    style: AppTextStyle.latoStyle(size: 16),
                  ),
                ),
                Container(
                  height: 20.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.h),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: CarouselSlider(
                      items: newsItem,
                      options: CarouselOptions(
                          height: 360,
                          viewportFraction: 1,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 900),
                          autoPlayCurve: Curves.easeInOut,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: newsItem.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => controller.animateToPage(entry.key),
                        child: AnimatedContainer(
                          curve: Curves.easeIn,
                          width: 2.h,
                          height: 1.h,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0.5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green.withOpacity(
                                  _current == entry.key ? 0.9 : 0.4)),
                          duration: const Duration(milliseconds: 600),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weather',
                        style: AppTextStyle.latoStyle(size: 12),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Details',
                          style: AppTextStyle.latoStyle(
                              size: 12, color: AppColors.green),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 40.h,
                  height: 20.h,
                  margin: EdgeInsets.only(right: 2.h, left: 2.h, bottom: 5.h),
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.green),
                      color: const Color(0xffD0FFE3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
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
                            Text('Chance of rain',
                                style: AppTextStyle.latoStyle(
                                    size: 18, color: AppColors.darkGrey)),
                            Text('No need of umbrella',
                                style: AppTextStyle.latoStyle(
                                    size: 14, color: AppColors.darkGrey)),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          'assets/images/r.png',
                          width: 127,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
