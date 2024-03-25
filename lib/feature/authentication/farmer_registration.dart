import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class FarmerRegistrationScreen extends ConsumerStatefulWidget {
  const FarmerRegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState
    extends ConsumerState<FarmerRegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String imageUrl = "";

  void signUpFarmer() async {
    final firstName = firstNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final firestore = ref.watch(firebaseFirestoreProvider);
    final auth = ref.watch(firebaseAuthProvider);

    if (firstName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        imageUrl.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Missing Information'),
            content: const Text('Please fill in all fields.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      final userRecord = {
        'uid': user!.uid,
        'firstName': firstName,
        'email': email,
        'role': "Farmer",
        'imageUrl': imageUrl,
        'status': "pending",
      };

      await firestore.collection('users').doc(user.uid).set(userRecord);

      Fluttertoast.showToast(msg: "user created successfully");

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(uid).get();

        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;

          if (userData['status'] == 'pending') {
            Navigation.navigateTo(Navigation.waitingScreen);
          }

          if (userData['status'] == 'approved') {
            Navigation.navigateTo(Navigation.farmerScreen);
          }
        }
      }

      firstNameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber[200],
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Farmer Registration"),
              TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: "Email", border: OutlineInputBorder())),
              TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                      hintText: "first name", border: OutlineInputBorder())),
              TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "password", border: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 300,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("upload image")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.camera);

                          if (file == null) return;
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('farmers_cards');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          try {
                            await referenceImageToUpload
                                .putFile(File(file.path));
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                          } catch (error) {
                            //Some error occurred
                          }
                        },
                        child: const Text("Take picture")),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    signUpFarmer();
                  },
                  child: const Text("register")),
            ],
          ),
        ),
      ),
    );
  }
}
