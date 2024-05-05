import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCustom({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.green,
        leading: Container(color: Colors.white,),
        actions: [Container(color: Colors.white,width: 6.h,)],
        centerTitle: true,
        title: Text(title,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.black),),
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
