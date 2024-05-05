import 'package:farmlynko/shared/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
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
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: ListView.builder(
                itemCount: HomeData.settingData(context: context).length,
                itemBuilder: (context, index) {
                  return _buildSettingItem(
                      onTap:
                          HomeData.settingData(context: context)[index].onTap,
                      title:
                          HomeData.settingData(context: context)[index].title);
                }),
          ))
        ],
      )),
    );
  }

  Widget _buildSettingItem(
      {required void Function() onTap, required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          color: const Color.fromARGB(255, 165, 255, 168),
          margin: EdgeInsets.only(bottom: 2.h),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 14.sp),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          )),
    );
  }
}
