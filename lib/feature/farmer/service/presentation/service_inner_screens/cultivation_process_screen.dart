import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/provider/cropcare_provider.dart';
import 'package:farmlynko/feature/farmer/service/presentation/service_inner_screens/cultivation_detail.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class CultivationProcessScreen extends ConsumerStatefulWidget {
  const CultivationProcessScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CultivationProcessScreen> createState() =>
      _CultivationScreenState();
}

class _CultivationScreenState extends ConsumerState<CultivationProcessScreen> {
  @override
  Widget build(BuildContext context) {
    final fetchCultivation = ref.watch(fetchCropDetailProvider);
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
          'Cultivation Process',
          style: AppTextStyle.latoStyle(size: 15),
        ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                              "Explore the intricate process of nurturing crops from seed to harvest with ",
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
                  ),
                  Gap(1.5.h),
                  Expanded(
                    child: fetchCultivation.when(
                        data: (data) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CultivationDetailScreen(
                                              cropCareModel: data[index],
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
                                                      size: 10,
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
