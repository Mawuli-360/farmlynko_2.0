import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/product_model.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/social_launch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key, required this.product});

  final ProductModel product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Product Detail",
          style: TextStyle(color: Colors.black),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
              child: SizedBox(
                  height: 30.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.h),
                    child: CachedNetworkImage(
                        imageUrl: widget.product.imageUrl,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 0.3.h,
                            ))),
                  )),
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.2.h),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Price: GHC ${widget.product.price}",
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    Gap(4.h),
                    SizedBox(
                      height: 10.h,
                      width: double.infinity,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.h),
                            child: CachedNetworkImage(
                              height: 8.h,
                              width: 8.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Image.asset("assets/images/avatar.png"),
                              imageUrl: widget.product.profilePic,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Gap(1.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Name of owner: ${widget.product.productOwner}",
                                style: TextStyle(fontSize: 12.sp),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              height: 8.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => SocialLaunch.launchWhatsApp(
                        widget.product.userPhoneNumber),
                    child: Container(
                      height: 6.h,
                      width: 47.w,
                      decoration: const ShapeDecoration(
                          color: AppColors.primaryColor,
                          shape: StadiumBorder()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Whatsapp Buyer",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Gap(1.5.h),
                          AppImages.whatsapp
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => SocialLaunch.launchPhoneCall(
                        widget.product.userPhoneNumber),
                    child: Container(
                      height: 6.h,
                      width: 47.w,
                      decoration: const ShapeDecoration(
                          color: AppColors.primaryColor,
                          shape: StadiumBorder()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Call Buyer",
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Gap(1.2.h),
                          Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 4.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
