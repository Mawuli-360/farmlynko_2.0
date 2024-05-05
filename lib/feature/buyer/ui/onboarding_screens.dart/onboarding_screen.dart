import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              Navigation.openWelcomeScreen(context: context);
            },
            child: Container(
              margin: EdgeInsets.all(1.h),
              height: 2.h,
              width: 20.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(10.h))),
              child: const Center(
                  child: Text(
                "Skip",
                style: TextStyle(color: Colors.green),
              )),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: PageView.builder(
                controller: pageController,
                itemCount: HomeData.pageViewnData().length,
                itemBuilder: (context, index) {
                  return _buildPageItem(
                      image: HomeData.pageViewnData()[index].image,
                      title: HomeData.pageViewnData()[index].title,
                      subtitle: HomeData.pageViewnData()[index].subtitle);
                }),
          ),
          SmoothPageIndicator(
              controller: pageController,
              count: HomeData.pageViewnData().length),
          SizedBox(
            height: 3.h,
          ),
          SizedBox(
            height: 10.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (pageController.page?.toInt() != 0) {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    height: 4.5.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(10.h))),
                    child: const Center(
                        child: Text(
                      "Back",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (pageController.page?.toInt() !=
                        HomeData.pageViewnData().length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // On the last page, perform actions like navigation to another screen
                      Navigation.openWelcomeScreen(context: context);
                    }
                  },
                  child: Container(
                    height: 4.5.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10.h))),
                    child: const Center(
                        child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          )
        ]),
      )),
    );
  }

  Widget _buildPageItem(
      {required AssetImage image,
      required String title,
      required String subtitle}) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 40.h,
          child: Center(
            child: Image(
              image: image,
              height: 25.h,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.5.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
