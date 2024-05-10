
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailsNotifier extends StateNotifier<User?> {
  UserDetailsNotifier() : super(null) {
    _subscribeToAuthStateChanges();
  }

  void _subscribeToAuthStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _fetchUserDetails(user.uid);
      } else {
        state = null;
      }
    });
  }

  Future<void> _fetchUserDetails(String uid) async {
    try {
      final userDocument = FirebaseFirestore.instance.collection('users').doc(uid);
      final snapshot = await userDocument.get();
      final data = snapshot.data();
      if (data != null) {
        final String email = data['email'] ?? '';
        final String name = data['fullName'] ?? '';
        final String phone = data['phone'] ?? '';
        final String imageUrl = data['imageUrl'] ?? '';
        state = User(email: email, name: name, phone: phone, imageUrl: imageUrl);
      } else {
        state = null;
      }
    } catch (e) {
      state = null;
    }
  }
}

// Usage in your UI
final userDetailsProvider = StateNotifierProvider<UserDetailsNotifier, User?>((ref) {
  return UserDetailsNotifier();
});
class User {
  final String email;
  final String name;
  final String phone;
  final String imageUrl;
  User({
    required this.email,
    required this.name,
    required this.phone,
    required this.imageUrl
  });
}
