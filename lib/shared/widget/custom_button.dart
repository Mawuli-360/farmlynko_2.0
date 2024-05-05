import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 40, left: 100, right: 100),
        height: 60,
        decoration: ShapeDecoration(shadows: [
          BoxShadow(
              color: const Color.fromARGB(57, 255, 153, 0),
              spreadRadius: 0.1.h,
              blurRadius: 3.h,
              offset: const Offset(10, 10))
        ], color: Colors.green, shape: const StadiumBorder()),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        )),
      ),
    );
  }
}
