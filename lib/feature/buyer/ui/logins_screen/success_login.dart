import 'dart:async';
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SuccessLogin extends ConsumerStatefulWidget {
  const SuccessLogin({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessLoginState();
}

class _SuccessLoginState extends ConsumerState<SuccessLogin> {


@override
  void initState() {
    super.initState();
        Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Lottie.asset("asset/images/successani.json")]),
      ),
    );
  }
}
