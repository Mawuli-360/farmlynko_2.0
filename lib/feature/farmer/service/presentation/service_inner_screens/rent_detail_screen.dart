import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class RentDetailScreen extends ConsumerStatefulWidget {
  const RentDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RentDetailScreen> createState() => _RentDetailScreenState();
}

class _RentDetailScreenState extends ConsumerState<RentDetailScreen> {
  List<String> option = ["rent", "buy"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Machinery',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        'https://www.agriculture.com/thmb/B-2q5mt0LpReuTbw4PQPaayaZIk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Tractors20for20sale20at20Cook20Auction-2000-f033f1283ab1498a93d3af41e663a4d4.jpg',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tractor',
                            style: AppTextStyle.latoStyle(
                                size: 12, color: AppColors.green),
                          ),
                          Text(
                            'Available in stock',
                            textAlign: TextAlign.start,
                            style: AppTextStyle.latoStyle(size: 12),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 24,
                              ),
                              Text(
                                'Highly rated',
                                style: AppTextStyle.latoStyle(size: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'GHC 200',
                                  style: AppTextStyle.latoStyle(size: 12),
                                ),
                                Text(
                                  '/kg',
                                  style: AppTextStyle.latoStyle(
                                      size: 10, color: AppColors.darkGrey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                            ),
                            child: Row(
                              children: List.generate(
                                  2,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                        },
                                        child: SizedBox(
                                          height: 6.h,
                                          width: 7.h,
                                          child: Card(
                                            color: index == selectedIndex
                                                ? AppColors.primaryColor
                                                : null,
                                            elevation: 2,
                                            child: Center(
                                                child: Text(
                                              option[index],
                                              style: AppTextStyle.latoStyle(
                                                  size: 10,
                                                  color: index == selectedIndex
                                                      ? AppColors.white
                                                      : AppColors.primaryColor),
                                            )),
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                  child: Text(
                    'Description',
                    style: AppTextStyle.latoStyle(size: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: Text(
                  'A tractor, a robust workhorse of the agricultural domain, boasts a sturdy build and versatile functionality. Its powerful engine effortlessly churns the soil, pulling heavy machinery with unwavering strength. Adorned with various attachments, it plows fields, hauls loads, and plants seeds with precision, embodying efficiency and reliability in farming practices. Its rugged tires grip the earth, navigating terrain with ease, while its ergonomic design ensures the operator\'s comfort during long hours of operation',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.latoStyle(
                      size: 10, color: AppColors.darkGrey),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                  child: Text(
                    'Related Products',
                    style: AppTextStyle.latoStyle(size: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              'https://www.agriculture.com/thmb/B-2q5mt0LpReuTbw4PQPaayaZIk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Tractors20for20sale20at20Cook20Auction-2000-f033f1283ab1498a93d3af41e663a4d4.jpg',
                            ),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
