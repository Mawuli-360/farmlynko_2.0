import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/shared/components/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';

class HireWorkerScreen extends ConsumerStatefulWidget {
  const HireWorkerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HireWorkerScreen> createState() => _HireWorkerScreenState();
}

class _HireWorkerScreenState extends ConsumerState<HireWorkerScreen> {
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
          'Hire Worker',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_outline,
              color: AppColors.black,
              size: 24,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ],
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
                        'https://content.fortune.com/wp-content/uploads/2020/04/Farm-Zuchinni-Harvest-Florida.jpg',
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
                            'Hire Worker',
                            style: AppTextStyle.latoStyle(size: 12),
                          ),
                          Text(
                            'Service Available',
                            textAlign: TextAlign.start,
                            style: AppTextStyle.latoStyle(
                                size: 12, color: AppColors.primaryColor),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.verified_sharp,
                                color: Color(0xFF3A99EE),
                                size: 24,
                              ),
                              Gap(0.5.h),
                              Text(
                                'Verified',
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
                                  '/worker',
                                  style: AppTextStyle.latoStyle(
                                      size: 10, color: AppColors.darkGrey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: 30.w,
                              height: 50,
                              padding: EdgeInsets.symmetric(vertical: 0.6.h),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomIconButton(
                                    height: 1.h,
                                    width: 1.w,
                                    color: AppColors.red,
                                    icon: Iconsax.minus,
                                    onTap: () {},
                                    border: 10,
                                    iconColor: AppColors.white,
                                  ),
                                  const Text(
                                    '1',
                                  ),
                                  CustomIconButton(
                                    height: 1.h,
                                    width: 1.w,
                                    color: AppColors.green,
                                    icon: Iconsax.add,
                                    onTap: () {},
                                    border: 10,
                                    iconColor: AppColors.white,
                                  ),
                                ],
                              )),
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
                    'Information',
                    style: AppTextStyle.latoStyle(size: 12),
                  ),
                ),
              ),
              const _CustomTextField(
                Icons.location_on_outlined,
                'Your address',
              ),
              const _CustomTextField(
                Icons.work_outline,
                'Type of work',
              ),
              const _CustomTextField(
                Icons.timer_outlined,
                'Working hours',
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 80.w,
                  height: 5.h,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "Hire worker",
                      style: AppTextStyle.latoStyle(
                          size: 12, color: AppColors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField(
    this.icon,
    this.label,
  );

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 2.h, vertical: 2.h),
      child: TextFormField(
        autofocus: true,
        obscureText: false,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: AppTextStyle.latoStyle(size: 12),
          hintStyle: AppTextStyle.latoStyle(size: 12),
          focusedBorder: const OutlineInputBorder(),
          prefixIcon: Icon(
            icon,
            color: AppColors.black,
          ),
        ),
        style: AppTextStyle.latoStyle(size: 12),
      ),
    );
  }
}
