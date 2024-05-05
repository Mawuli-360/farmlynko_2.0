import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.1;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 1.2;
        _containerOpacity = 1;
      });
    });

    checkCurrentUser().then((initialRoute) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, initialRoute);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> checkCurrentUser() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final User? currentUser = firebaseAuth.currentUser;
      if (currentUser != null && currentUser.uid.isNotEmpty) {
        // Check if the user is authenticated
        String uid = currentUser.uid;
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(uid).get();
        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;
          String role = userData['role'];
          if (role == 'Farmer') {
            return Navigation.farmerScreen;
          } else if (role == 'Buyer') {
            return Navigation.homeScreen;
          }
        }
      }
      // If the user is not authenticated or their role is not found, return the login screen
      return Navigation.loginScreen;
    } catch (e) {
      // print('Error: $e');
      return Navigation.loginScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff0f251b),
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / _fontSize * 0.074.h),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'FARMLYNCO',
                  style: TextStyle(
                    fontFamily: 'BlackOpsOne',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1.value * 0.17.h,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: width / _containerSize,
                  width: width / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image(
                    height: 100.h,
                    width: 100.h,
                    image: AppImages.logo,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final String page;
  final Widget Function(BuildContext context, String routeName) builder;

  PageTransition(this.page, this.builder)
      : super(
          pageBuilder: (context, animation, anotherAnimation) =>
              builder(context, page),
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: child,
              ),
            );
          },
        );
}
