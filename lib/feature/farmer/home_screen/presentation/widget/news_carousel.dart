import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewsCarousel extends StatelessWidget {
  const NewsCarousel({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: const ColorFilter.mode(
                  Color(0x52000000), BlendMode.colorBurn),
              image: image,
              fit: BoxFit.fill),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp),
            ),
          ),
        ),
      ),
    );
  }
}
