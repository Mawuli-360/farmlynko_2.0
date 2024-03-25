import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onTap,
    required this.color,
    required this.icon,
    required this.border,
    required this.iconColor,
  }) : super(key: key);

  final double height;
  final double width;
  final void Function() onTap;
  final Color color;
  final IconData icon;
  final double border;
  final Color  iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width.h,
        height: height.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
