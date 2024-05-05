import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/buyer/provider/firebase_firestore.dart';
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_toast/tasty_toast.dart';

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final nameProvider = StateProvider<String>((ref) => '');
final phoneNumberProvider = StateProvider<String>((ref) => '');
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authExceptionProvider = StateProvider<String?>((ref) => null);
final isLoading = StateProvider<bool>((ref) => false);

class AuthService {
  static Future<bool> authenticateUser(
      String selectedRole, WidgetRef ref, BuildContext context) async {
    final String email = ref.read(emailProvider.notifier).state.trim();
    final String password = ref.read(passwordProvider.notifier).state.trim();
    ref.read(isLoading.notifier).state = true;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        String role = userData['role'];

        // Check if the selected role matches the user's role
        if (role == selectedRole) {
          // Authentication successful
          ref.read(isLoading.notifier).state = false;
          return true;
        } else {
          // Roles don't match, show an error message
          showToast(context, 'Selected role does not match user role');
          ref.read(isLoading.notifier).state = false;
          await FirebaseAuth.instance.signOut();

          return false;
        }
      } else {
        showToast(context, 'User not found');
        ref.read(isLoading.notifier).state = false;
        return false;
      }
    } catch (e) {
      print('Error: $e');
      ref.read(isLoading.notifier).state = false;
      return false;
    }
  }

  static Future<void> navigateToRoleScreen(
      {required BuildContext context}) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final User? currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(uid).get();
        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;
          String role = userData['role'];
          if (role == 'Farmer') {
            // Navigate to the farmer screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FarmerMainScreen()),
            );
          } else if (role == 'Buyer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            // Handle the case when the user has a different role
            showToast(context, 'Invalid user role');
          }
        } else {
          // Handle the case when the user document does not exist
          showToast(context, 'User document not found');
        }
      } else {
        // Handle the case when the user is not authenticated
        showToast(context, 'User not authenticated');
      }
    } catch (e) {
      // print('Error: $e');
      showToast(context, '$e');
    }
  }

  static void signInWithEmailAndPassword(
      {required BuildContext context, required WidgetRef ref}) async {
    try {
      final String email = ref.read(emailProvider.notifier).state.trim();
      final String password = ref.read(passwordProvider.notifier).state.trim();

      UserCredential userCredential =
          await ref.watch(authProvider).signInWithEmailAndPassword(
                email: email,
                password: password,
              );

      // Check if the user exists
      if (userCredential.user != null) {
        // Navigate to the home screen
        await navigateToRoleScreen(context: context);
      } else {
        // Handle the case when the user does not exist

        ref.read(authExceptionProvider.notifier).state = 'User does not exist.';
      }
    } catch (e) {
      showToast(context, "$e");
    }
  }

  static void signUpWithEmailAndPassword(
      {required BuildContext context, required WidgetRef ref}) async {
    try {
      final String email = ref.read(emailProvider.notifier).state.trim();
      final String password = ref.read(passwordProvider.notifier).state.trim();
      final String name = ref.read(nameProvider.notifier).state.trim();
      final String phoneNumber =
          ref.read(phoneNumberProvider.notifier).state.trim();

      UserCredential userCredential =
          await ref.watch(authProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
              );

      await ref
          .watch(firestoreProvider)
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'phone': phoneNumber,
      });

      if (userCredential.user != null) {
        Navigation.openSuccessLoginScreen(context: context);
      } else {
        ref.read(authExceptionProvider.notifier).state = 'User does not exist.';
      }
    } catch (e) {
      ref.read(authExceptionProvider.notifier).state = 'Error signing up: $e';

      showToast(context, e.toString());
    }
  }
}

class FarmerScreen {
  const FarmerScreen();
}
