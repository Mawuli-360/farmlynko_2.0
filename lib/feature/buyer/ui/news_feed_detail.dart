import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/newsfeed_model.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

class NewsFeedDetailScreen extends StatelessWidget {
  const NewsFeedDetailScreen({super.key, required this.news});

  final NewsFeedModel news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(),
          SizedBox(
            width: double.infinity,
            height: 25.h,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AppImages.carrotfarming, fit: BoxFit.fill)),
            child: CachedNetworkImage(
              imageUrl: news.image,
              fit: BoxFit.fill,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 0.3.h,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                width: 100.w,
                color: Colors.white,
                height: 72.h,
                child: Padding(
                  padding: EdgeInsets.all(3.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Text(
                            news.date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: Colors.grey),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Html(
                            data: news.content,
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 4.h,
              width: 4.h,
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
        ],
      )),
    );
  }
}
