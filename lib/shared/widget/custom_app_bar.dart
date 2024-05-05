import 'package:farmlynko/main.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.isTitleCentered = false,
    required this.title,
  });

  final bool isTitleCentered;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(title,
            style: AppTextStyle.latoStyle(
                size: 15, color: AppColors.primaryColor)),
        automaticallyImplyLeading: false,
        centerTitle: isTitleCentered,
        leading: IconButton(
            icon: const Icon(
              Icons.segment_rounded,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              drawerController.toggle?.call();
            }));
  }

  @override
  Size get preferredSize => Size.fromHeight(6.h);
}
