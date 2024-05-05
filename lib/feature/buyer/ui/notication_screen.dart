import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool value4 = false;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notification",
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
      body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              _buildNotificationItem(
                  title: "Allow Notification",
                  subtitle:
                      "Allows us to send you a notification on news update",
                  value: value4,
                  onChanged: (value) {
                    setState(() {
                      value4 = value;
                    });
                  }),
              SizedBox(
                height: 3.h,
              ),
              _buildNotificationItem(
                  title: "Email Notification",
                  subtitle:
                      "Allows us to send you a mails on updates amd news letter",
                  value: value1,
                  onChanged: (value) {
                    setState(() {
                      value1 = value;
                    });
                  }),
              SizedBox(
                height: 3.h,
              ),
              _buildNotificationItem(
                  title: "Order Notification",
                  subtitle: "Receive a notification on your order process",
                  onChanged: (value) {
                    setState(() {
                      value2 = value;
                    });
                  },
                  value: value2),
              SizedBox(
                height: 3.h,
              ),
              _buildNotificationItem(
                  title: "General Notification",
                  subtitle:
                      "Receive general information concerning the Farmily app",
                  value: value3,
                  onChanged: (value) {
                    setState(() {
                      value3 = value;
                    });
                  }),
            ],
          )),
      bottomNavigationBar: CustomButton(
        onTap: () {},
        title: "Save Settings",
      ),
    );
  }

  Widget _buildNotificationItem(
      {required bool value,
      required String title,
      required String subtitle,
      required Function(bool) onChanged}) {
    return ListTile(
      trailing:
          Switch(activeColor: Colors.green, value: value, onChanged: onChanged),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
    );
  }
}
