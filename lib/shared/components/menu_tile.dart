// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key? key,
    required this.icon,
    required this.menu,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String menu;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      child: Container(
        color: const Color.fromARGB(61, 245, 245, 245),
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
