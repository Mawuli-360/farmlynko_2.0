import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Change Password",
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
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: Column(
          children: [
            SizedBox(
              height: 6.h,
            ),
            _buildTextField(title: 'Current Password', hintText: ''),
            _buildTextField(title: 'New Password', hintText: ''),
            _buildTextField(title: 'Confirm Password', hintText: ''),
          ],
        ),
      )),
      bottomNavigationBar: CustomButton(
        onTap: () {},
        title: "Save Settings",
      ),
    );
  }

  Widget _buildTextField({required String title, required String hintText}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
        ],
      ),
    );
  }
}
