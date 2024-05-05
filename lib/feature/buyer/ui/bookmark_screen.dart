import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/newsfeed_model.dart';
import 'package:farmlynko/feature/buyer/provider/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(bookmarkProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Bookmarks",
            style: TextStyle(color: Colors.black),
          ),
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
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: news.isEmpty
                    ? const Center(
                        child: Text("BOOKMARK IS EMPTY"),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: news.length,
                        itemBuilder: (context, index) => _buildNewsFeedItem(
                            context: context,
                            news: news[index],
                            onPressed: () {
                              ref
                                  .read(bookmarkProvider.notifier)
                                  .removeFromBookmark(news[index]);
                              showToast(context, "News remove from bookmark");
                            })),
              ),
            ],
          ),
        ));
  }

  Widget _buildNewsFeedItem(
      {required BuildContext context,
      required NewsFeedModel news,
      required void Function()? onPressed}) {
    return GestureDetector(
      onTap: () {},
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
                padding: EdgeInsets.all(1.h),
                width: 140,
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
                              icon: const Icon(
                                Icons.bookmark,
                                color: Colors.green,
                              ))
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
