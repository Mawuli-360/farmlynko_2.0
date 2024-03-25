import 'package:bubble/bubble.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum Sender { user, bot }

class Messages extends StatelessWidget {
  const Messages({super.key, required this.text, required this.sender});

  final String text;
  final Sender sender;

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(bottom: 2.h),
      color: sender == Sender.user
          ? const Color(0xFF7CBBF0)
          : AppColors.primaryColor,
      borderColor: sender == Sender.user
          ? AppColors.primaryColor
          : const Color(0xFF7CBBF0),
      showNip: true,
      nip: sender == Sender.user ? BubbleNip.rightBottom : BubbleNip.leftBottom,
      alignment:
          sender == Sender.user ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: sender == Sender.user ? AppColors.darkGrey : AppColors.white,
        ),
      ),
    );
  }
}
