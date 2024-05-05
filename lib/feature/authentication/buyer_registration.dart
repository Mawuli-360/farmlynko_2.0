import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class BuyerRegistrationScreen extends ConsumerStatefulWidget {
  const BuyerRegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BuyerRegistrationScreenState();
}

class _BuyerRegistrationScreenState
    extends ConsumerState<BuyerRegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpBuyer() async {
    final firstName = firstNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final firestore = ref.watch(firebaseFirestoreProvider);
    final auth = ref.watch(firebaseAuthProvider);

    if (firstName.isEmpty || email.isEmpty || password.isEmpty) {
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
        'firstName': firstName,
        'email': email,
        'role': "Buyer",
      };

      await firestore.collection('users').doc(user!.uid).set(userRecord);

      Fluttertoast.showToast(msg: "user created successfully");

      if (userCredential.user != null) {
        Navigation.navigateTo(Navigation.buyerScreen);
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[200],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: Container(
        color: Colors.amber[200],
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Register", style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => signUpBuyer(), child: const Text("Register"))
          ]),
        ),
      ),
    );
  }
}

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

  void signUpBuyer() async {
    final fullName = fullNameController.text;
    final email = emailController.text;
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

      Fluttertoast.showToast(msg: "user created successfully");

      if (userCredential.user != null) {
        Navigation.navigateTo(Navigation.homeScreen);
      }

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
                      height: 5.h,
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
                    SizedBox(
                      width: double.infinity,
                      height: 21.h,
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
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
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
      height: 10.h,
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
