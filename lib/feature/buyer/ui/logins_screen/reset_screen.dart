import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
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
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Reset Password",
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text(
                  "Please enter your email address to\nrequest a passowrd reset",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4.h,
                ),
                _buildTextField(
                    title: '', hintText: 'eg. alexduncan@gmail.com'),
                SizedBox(
                  width: double.infinity,
                  height: 25.h,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 1.h, left: 4.h, right: 4.h),
                          height: 60,
                          decoration: ShapeDecoration(shadows: [
                            BoxShadow(
                                color: const Color.fromARGB(57, 102, 101, 99),
                                spreadRadius: 0.1.h,
                                blurRadius: 3.h,
                                offset: const Offset(10, 10))
                          ], color: Colors.green, shape: const StadiumBorder()),
                          child: const Center(
                              child: Text(
                            "RESET PASSWORD",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
