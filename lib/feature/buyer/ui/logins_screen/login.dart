import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/authentication/email_verification_screen.dart';
import 'package:farmlynko/feature/authentication/registration_screen.dart';
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/service/auth_service.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String selectedRole = "Farmer";
  bool isPassword = true;

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

  void _handleAuthentication(String selectedRole) async {
    bool isAuthSuccessful =
        await AuthService.authenticateUser(selectedRole, ref, context);

    if (isAuthSuccessful) {
      // Authentication successful
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? currentUser = firebaseAuth.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        // User is authenticated and the selected role matches
        String uid = currentUser.uid;
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(uid).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          String role = userData['role'];

          if (role == 'Buyer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (role == 'Farmer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FarmerMainScreen()),
            );
          }
        } else {
          // User document not found in Firestore
          showToast(context, 'User document not found');
        }
      }
      if (currentUser != null && !currentUser.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EmailVerificationScreen(user: currentUser)),
        );
      } else {
        // User is not authenticated or the selected role doesn't match
        // showToast(context, 'Authentication failed');
      }
    } else {
      // Authentication failed
      showToast(context, 'Authentication failed');
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
                child: const Text(
                  "YES",
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: 100.h,
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
                      "Login",
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    _buildTextField(
                        title: 'E-mail',
                        hintText: 'eg. alexduncan@gmail.com',
                        onChanged: (value) {
                          ref.read(emailProvider.notifier).state = value;
                        }),
                    _buildTextField(
                        title: 'password',
                        hintText: '',
                        isPassword: isPassword,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            icon: isPassword
                                ? Icon(
                                    Icons.visibility_off,
                                    color: AppColors.primaryColor,
                                    size: 3.h,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: AppColors.primaryColor,
                                    size: 3.h,
                                  )),
                        onChanged: (value) {
                          ref.read(passwordProvider.notifier).state = value;
                        }),
                    SizedBox(
                      width: double.infinity,
                      height: 30.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigation.openResetScreen(context: context);
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.green),
                              )),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Farmer",
                                    groupValue: selectedRole,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRole = value!;
                                      });
                                    },
                                  ),
                                  const Text('Farmer'),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: "Buyer",
                                    groupValue: selectedRole,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRole = value!;
                                      });
                                    },
                                  ),
                                  const Text('Buyer'),
                                ],
                              ),
                            ],
                          ),
                          Gap(1.h),
                          GestureDetector(
                            onTap: () async {
                              if (ref
                                      .read(emailProvider.notifier)
                                      .state
                                      .isEmpty &&
                                  ref
                                      .read(passwordProvider.notifier)
                                      .state
                                      .isEmpty) {
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Missing Information'),
                                      content: const Text(
                                          'Please fill in all fields.'),
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
                              }
                              _handleAuthentication(selectedRole);
                            },
                            child: ref.watch(isLoading)
                                ? SizedBox(
                                    height: 3.h,
                                    width: double.infinity,
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    )))
                                : Container(
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
                                      "LOGIN",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    )),
                                  ),
                          ),
                          Gap(2.h),
                          SizedBox(
                            width: 100.w,
                            height: 4.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegistrationScreen()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                    ),
                                    // style: ButtonStyle(padding: MaterialStateProperty),
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 12.sp),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(0.5.h),
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
                    Gap(2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => signInWithGoogle(context),
                          child: Container(
                            height: 6.h,
                            padding: EdgeInsets.symmetric(horizontal: 2.h),
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
      bool isPassword = false,
      Widget? suffixIcon}) {
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
            onChanged: onChanged,
            obscuringCharacter: "*",
            obscureText: isPassword,
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: suffixIcon,
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
