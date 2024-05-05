import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key? key,
    required this.icon,
    required this.menu,
    required this.onTap,
    this.color = const Color.fromARGB(33, 245, 245, 245),
  }) : super(key: key);

  final IconData icon;
  final String menu;
  final void Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      child: Container(
        color: color,
        margin: EdgeInsets.symmetric(vertical: 1.h),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.white,
          ),
          title: Text(
            menu,
            style: AppTextStyle.latoStyle(size: 13, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
