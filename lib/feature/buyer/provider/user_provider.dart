// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDetailsProvider = StreamProvider<User>((ref) {
  // Get the current authenticated user
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    // Replace 'users' with the actual collection name in your Firestore
    final userDocument =
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

    // Return a stream of user details from the Firestore
    return userDocument.snapshots().map((snapshot) {
      final data = snapshot.data();
      final String email = data?['email'] ?? '';
      final String name = data?['fullName'] ?? '';
      final String phone = data?['phone'] ?? '';

      // Return the User model
      return User(email: email, name: name, phone: phone);
    });
  } else {
    throw Exception('User is not authenticated');
  }
});

class User {
  final String email;
  final String name;
  final String phone;
  User({
    required this.email,
    required this.name,
    required this.phone,
  });
}
