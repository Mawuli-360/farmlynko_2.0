import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/newsfeed_model.dart';
import 'package:farmlynko/feature/buyer/provider/bookmark_provider.dart';
import 'package:farmlynko/feature/buyer/provider/newsfeed_provider.dart';
import 'package:farmlynko/feature/buyer/ui/news_feed_detail.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_strings.dart';
import 'package:farmlynko/shared/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class NewsFeed extends ConsumerWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsList = ref.watch(fetchNewsDetailProvider);
    final bookmarkedItems = ref.watch(bookmarkProvider);

    return Scaffold(
      appBar: CustomAppBar(
          title: "Farmlynco",
          onTap: () {
            Navigator.pop(context);
          },
          image: AppImages.back),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.h),
          child: const Text(
            AppStrings.newsFeed,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Flexible(
            child: newsList.when(
                data: (data) {
                  return AnimationLimiter(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final newsFeed = data[index];
                          final isBookmarked = bookmarkedItems
                              .any((item) => item.id == newsFeed.id);

                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 700),
                              child: SlideAnimation(
                                  verticalOffset: 50,
                                  child: FadeInAnimation(
                                      child: _buildNewsFeedItem(
                                          context: context,
                                          news: data[index],
                                          onPressed: () {
                                            ref
                                                .read(bookmarkProvider.notifier)
                                                .toggleBookmark(data[index]);
                                            isBookmarked
                                                ? showToast(context,
                                                    "News remove from bookmark")
                                                : showToast(context,
                                                    "News added to bookmark");
                                          },
                                          isBookmarked: isBookmarked))));
                        }),
                  );
                },
                error: (error, st) => Text(error.toString()),
                loading: () => const CircularProgressIndicator()))
      ]),
    );
  }

  Widget _buildNewsFeedItem(
      {required BuildContext context,
      required NewsFeedModel news,
      required void Function()? onPressed,
      required bool isBookmarked}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsFeedDetailScreen(
                      news: news,
                    )));
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          margin: EdgeInsets.only(bottom: 4.h, left: 2.h, right: 2.h),
          height: 18.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(75, 158, 158, 158)),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(29, 0, 0, 0),
                  spreadRadius: 0.1.h,
                  offset: const Offset(4, 10),
                  blurRadius: 2.h)
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              Container(
                width: 140,
                padding: EdgeInsets.all(1.h),
                height: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(20))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: news.image,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 0.3.h,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        news.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        news.description,
                        maxLines: 2,
                        style: TextStyle(fontSize: 9.sp),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            news.date,
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: onPressed,
                            icon: isBookmarked
                                ? const Icon(Icons.bookmark)
                                : const Icon(Icons.bookmark_outline_sharp),
                            color: isBookmarked ? Colors.green : null,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
