import 'package:farmlynko/routes/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'authentication_provider.g.dart';

@riverpod
class AuthService extends _$AuthService {
  @override
  FutureOr build() {}

  Stream<User?> authStateChanges() {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    return firebaseAuth.authStateChanges();
  }

  Future<void> login(String email, String password, String role) async {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final firestore = ref.read(firebaseFirestoreProvider);
    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    String uid = userCredential.user!.uid;
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(uid).get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;

      if (userData['role'] == 'Farmer' && role == "Farmer") {
        if (userData['status'] == 'pending') {
          Navigation.navigateTo(Navigation.waitingScreen);
        }
        if (userData['status'] == 'approved') {
          Navigation.navigateTo(Navigation.farmerScreen);
        }
      }

      if (userData['role'] == 'Buyer' && role == "Buyer") {
        Navigation.navigateTo(Navigation.buyerScreen);
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigation.navigateTo(Navigation.loginScreen);
  }
}

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}
