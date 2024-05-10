import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/authentication/email_verification_screen.dart';
import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/service/auth_service.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class BuyerRegisterScreen extends ConsumerStatefulWidget {
  const BuyerRegisterScreen({super.key});

  @override
  ConsumerState<BuyerRegisterScreen> createState() =>
      _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends ConsumerState<BuyerRegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Show a modal progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      );

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // If the user cancels the Google Sign-In flow
      if (googleAuth == null) {
        // Close the modal progress indicator
        Navigator.of(context).pop();
        showToast(context, 'No account found. Please try again.');
        return;
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = userCredential.user;

      if (user != null) {
        // Check if the user exists in the "users" collection
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(user.uid).get();

        // If the user doesn't exist, create a new document for them
        if (!userSnapshot.exists) {
          // Set the default role for new users (e.g., "Buyer")
          String role = "Buyer";

          // Create a new document in the "users" collection
          await firestore.collection('users').doc(user.uid).set({
            'fullName': user.displayName,
            'email': user.email,
            'role': role,
            // Add any other user data you need
          });
        }

        if (userCredential.user != null) {
          // Close the modal progress indicator
          Navigator.of(context).pop();

          // Navigate to the home screen
          Navigation.navigateTo(Navigation.homeScreen);
        }
      }
    } catch (e) {
      // Close the modal progress indicator
      Navigator.of(context).pop();
      showToast(context, e.toString());
    }
  }

  void signUpBuyer() async {
    final fullName = fullNameController.text;
    final email = emailController.text.trim();
    final password = passwordController.text;
    final firestore = ref.watch(firebaseFirestoreProvider);
    final auth = ref.watch(firebaseAuthProvider);

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
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
        'fullName': fullName,
        'email': email,
        'role': "Buyer",
      };

      await firestore.collection('users').doc(user!.uid).set(userRecord);

      // Send email verification
      await user.sendEmailVerification();
      final currentUser = auth.currentUser;

      Fluttertoast.showToast(
          msg: "user created successfully, please verify your email.");

      // Navigate to the email verification screen
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => EmailVerificationScreen(
                    user: currentUser!,
                  )));
      ref.watch(isBuyerSigningUp.notifier).state = false;

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      ref.watch(isBuyerSigningUp.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("NO"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: const Text("YES"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Buyer Sign Up",
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    _buildTextField(
                        title: 'Full name',
                        hintText: '',
                        onChanged: (value) {
                          fullNameController.text = value;
                        },
                        controller: fullNameController),
                    _buildTextField(
                        title: 'E-mail',
                        hintText: 'eg. alexduncan@gmail.com',
                        onChanged: (value) {
                          emailController.text = value;
                        },
                        controller: emailController),
                    _buildTextField(
                        title: 'password',
                        hintText: '',
                        onChanged: (value) {
                          passwordController.text = value;
                        },
                        controller: passwordController),
                    ref.watch(isBuyerSigningUp)
                        ? const Center(child: CircularProgressIndicator())
                        : GestureDetector(
                            onTap: () {
                              ref.read(isBuyerSigningUp.notifier).state = true;
                              signUpBuyer();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 1.h, left: 4.h, right: 4.h),
                              height: 6.h,
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        color: const Color.fromARGB(
                                            57, 102, 101, 99),
                                        spreadRadius: 0.1.h,
                                        blurRadius: 3.h,
                                        offset: const Offset(10, 10))
                                  ],
                                  color: Colors.green,
                                  shape: const StadiumBorder()),
                              child: Center(
                                  child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              )),
                            ),
                          ),
                    Gap(2.h),
                    SizedBox(
                      width: double.infinity,
                      height: 24.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 0.05.h,
                                  color: Colors.grey,
                                  width: 15.h,
                                ),
                                const Text("Sign in with"),
                                Container(
                                  height: 0.05.h,
                                  color: Colors.grey,
                                  width: 15.h,
                                ),
                              ],
                            ),
                          ),
                          Gap(3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => signInWithGoogle(context),
                                child: Container(
                                  height: 6.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.h),
                                  width: 70.w,
                                  decoration: ShapeDecoration(
                                      shadows: [
                                        BoxShadow(
                                            color: const Color.fromARGB(
                                                57, 102, 101, 99),
                                            spreadRadius: 0.1.h,
                                            blurRadius: 3.h,
                                            offset: const Offset(10, 10))
                                      ],
                                      color: Colors.white,
                                      shape: const StadiumBorder()),
                                  child: Row(
                                    children: [
                                      Gap(2.h),
                                      AppImages.google,
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      Gap(2.h),
                                      Text(
                                        "GOOGLE",
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.green),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(1.5.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String title,
      required String hintText,
      required void Function(String) onChanged,
      required TextEditingController controller,
      TextInputType? textInputType}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      height: 12.h,
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
          SizedBox(
            height: 6.h,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: textInputType,
              decoration: InputDecoration(
                  hintText: hintText,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
        ],
      ),
    );
  }
}
