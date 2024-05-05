import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/cropcare_model.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

class CropCareDetail extends StatelessWidget {
  const CropCareDetail({super.key, required this.crop});

  final CropCareModel crop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Stack(
        children: [
          Stack(
            children: [
              Container(),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: SizedBox(
                  width: double.infinity,
                  height: 230,
                  child: CachedNetworkImage(
                    imageUrl: crop.image,
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
              Container(
                height: 230,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(99, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
              ),
              Positioned(
                top: 20.h,
                left: 18.h,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Text(
                    crop.title,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                  margin: EdgeInsets.only(left: 2.h, top: 6.h),
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
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: 100.w,
              height: 72.h,
              child: Padding(
                padding: EdgeInsets.all(3.h),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Html(data: crop.content),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2.h,
            child: Container(
              width: 100.w,
              height: 10.h,
              color: Colors.transparent,
              child: Center(
                child: CustomButton(
                  onTap: () {
                    Navigation.openExpertiseScreen(context: context);
                  },
                  title: "CONTACT EXPERTISE",
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
