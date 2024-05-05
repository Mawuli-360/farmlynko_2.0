import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmlynko/feature/farmer/blog/news_screen.dart';
import 'package:farmlynko/feature/farmer/home_screen/presentation/widget/news_carousel.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({
    super.key,
  });

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  CarouselController controller = CarouselController();
  int _current = 0;

  List<NewsCarousel> newsItem = [
    const NewsCarousel(
        title: "Farmer Associations call for PFJ audit",
        image: AppImages.planting),
    const NewsCarousel(
        title:
            "Cocoa farmers in the Western region welcome\npension scheme project",
        image: AppImages.cocoafarmers),
    const NewsCarousel(
        title: "How to successfully grow and harvest carrots",
        image: AppImages.carrotfarming),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.h, bottom: 1.2.h, top: 1.5.h),
          child: Text(
            'News',
            style:
                AppTextStyle.latoStyle(size: 16, color: AppColors.primaryColor),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const NewsScreen()));
            // Navigation.openNewsDetailScreen(context: context);
          },
          child: Container(
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
                      color: Colors.green
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  duration: const Duration(milliseconds: 600),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
