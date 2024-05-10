import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/provider/newsfeed_provider.dart';
import 'package:farmlynko/feature/farmer/blog/news_detail_screen.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final fetchNews = ref.watch(fetchNewsDetailProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'News',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: SizedBox(
              height: 100.h,
              width: double.infinity,
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            "Stay informed with the latest updates delivered straight to your fingertips with ",
                        style: AppTextStyle.latoStyle(
                            size: 11,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(148, 0, 0, 0)),
                        children: const [
                          TextSpan(
                              text: "Farmlynco",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                        ]),
                  ),
                  Gap(1.5.h),
                  Expanded(
                    child: fetchNews.when(
                        data: (data) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NewsDetailScreen(
                                              newsFeedModel: data[index],
                                            )));
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.h)),
                                child: Card(
                                  elevation: 3,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0.5.h, vertical: 0.9.h),
                                        width: 30.6.w,
                                        height: 13.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1.h)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                data[index].image),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: const AlignmentDirectional(
                                              -1.00, 0.00),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 5, 5, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -1.00, 0.00),
                                                  child: Text(
                                                    data[index].title,
                                                    maxLines: 2,
                                                    style:
                                                        AppTextStyle.latoStyle(
                                                      size: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  data[index].description,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle.latoStyle(
                                                      size: 9,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          AppColors.darkGrey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        error: (error, st) => Text(error.toString()),
                        loading: () => const Center(
                              child: CircularProgressIndicator(),
                            )),
                  ),
                  Gap(3.h)
                ],
              )),
        ),
      ),
    );
  }
}
