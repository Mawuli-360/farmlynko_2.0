import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 220,
                    color: Colors.yellow,
                    child: Stack(
                      children: [
                        Container(color: Colors.white),
                        Container(
                          height: 180,
                          color: Colors.white,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Center(
                                  child: CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 50,
                                backgroundImage: AppImages.avatar,
                              )),
                            )),
                        const Positioned(
                            right: 150,
                            bottom: 15,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.blue,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Try Farmily",
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      title: 'Full name',
                      hintText: 'eg. Alex Duncan',
                      controller: fullNameController,
                    ),
                    _buildTextField(
                        title: 'E-mail',
                        hintText: 'eg. alexdunny@gmail.com',
                        controller: emailController),
                    _buildTextField(
                        title: 'Phone',
                        hintText: 'eg. +233545786643',
                        controller: phoneController),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        )),
        bottomNavigationBar: CustomButton(
          onTap: _saveProfileDetails,
          title: "Save",
        ));
  }

  Widget _buildTextField(
      {required String title,
      required String hintText,
      required TextEditingController controller}) {
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
            controller: controller,
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

  void _saveProfileDetails() async {
    String name = fullNameController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    // Get the currently signed-in user
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Access the Firebase Firestore instance
      final firestoreInstance = FirebaseFirestore.instance;

      // Replace 'users' with the collection name where you want to store user profiles
      final userCollection = firestoreInstance.collection('users');

      try {
        // Use the user's UID as the document ID
        await userCollection.doc(user.uid).set({
          'email': email,
          'name': name,
          'phone': phone,
        });

        // print("Profile details saved to Firestore.");
      } catch (e) {
        // print("Error saving profile details: $e");
      }
    } else {
      // print("User not signed in.");
    }
  }
}
