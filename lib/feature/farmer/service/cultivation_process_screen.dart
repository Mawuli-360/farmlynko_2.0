import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class CultivationProcessScreen extends ConsumerStatefulWidget {
  const CultivationProcessScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CultivationProcessScreen> createState() =>
      _CultivationProcessScreenState();
}

class _CultivationProcessScreenState
    extends ConsumerState<CultivationProcessScreen> {
  @override
  Widget build(BuildContext context) {
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
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 1.h),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Text(
                          'vegetable',
                          style: AppTextStyle.latoStyle(
                              size: 12,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Text(
                          'crops',
                          style: AppTextStyle.latoStyle(
                              size: 12, color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 3.h, 10, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(2.h)),
                child: Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.5.h, vertical: 0.9.h),
                        width: 146,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(1.h)),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              'https://www.agriculture.com/thmb/B-2q5mt0LpReuTbw4PQPaayaZIk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Tractors20for20sale20at20Cook20Auction-2000-f033f1283ab1498a93d3af41e663a4d4.jpg',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(-1.00, 0.00),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 5, 5, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.00, 0.00),
                                  child: Text(
                                    'Rice Cultivation',
                                    style: AppTextStyle.latoStyle(
                                      size: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  'asadsddddddddddddddddddddddasddddddddddddddddddddddddadaaaaaaaaaaaaaaaaaa',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.latoStyle(
                                      size: 9,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.darkGrey),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.00, 0.00),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        shape: const StadiumBorder(),
                                        minimumSize: const Size(100, 30),
                                        maximumSize: const Size(100, 30),
                                        textStyle: AppTextStyle.latoStyle(
                                          size: 8,
                                        )),
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    child: const Text(
                                      'View Details',
                                    ),
                                  ),
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
          ],
        ),
      ),
    );
  }
}
