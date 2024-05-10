import 'dart:async';

import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class EmailVerificationScreen extends StatefulWidget {
  final User user;

  const EmailVerificationScreen({Key? key, required this.user})
      : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isResendLinkAvailable = true;
  Timer? _resendTimer;
  Timer? _countdownTimer;
  int _remainingSeconds = 60;

  Future<void> continueToLogin() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: const Text('Email Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail_outline,
                color: AppColors.primaryColor,
                size: 10.h,
              ),
              Gap(4.h),
              const Text(
                'Please verify your email address',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.primaryColor,
                  ),
                ),
                onPressed: _isResendLinkAvailable
                    ? () {
                        _sendVerificationEmail(widget.user);
                        _startResendTimer();
                      }
                    : null,
                child: const Text('Resend Verification Email'),
              ),
              if (!_isResendLinkAvailable) const SizedBox(height: 16.0),
              if (!_isResendLinkAvailable)
                Text(
                  'You can resend the verification email in $_remainingSeconds seconds.',
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              if (!_isResendLinkAvailable) const SizedBox(height: 16.0),
              if (!_isResendLinkAvailable)
                Text(
                  'Verification email sent to ${widget.user.email}',
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.primaryColor,
                  ),
                ),
                onPressed: () => continueToLogin(),
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendVerificationEmail(User user) async {
    await user.sendEmailVerification();
    Fluttertoast.showToast(msg: 'Verification email sent');
  }

  void _startResendTimer() {
    const resendDelay = Duration(seconds: 60);

    _resendTimer = Timer.periodic(resendDelay, (timer) {
      setState(() {
        _isResendLinkAvailable = true;
        _remainingSeconds = 60;
      });
      _resendTimer?.cancel();
      _countdownTimer?.cancel();
    });

    setState(() {
      _isResendLinkAvailable = false;
      _remainingSeconds = 60;
    });

    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
      });
      if (_remainingSeconds == 0) {
        _countdownTimer?.cancel();
      }
    });
  }
}