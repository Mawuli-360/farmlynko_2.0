// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

// final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// final userProvider = StreamProvider<User?>((ref) {
//   return ref.watch(authProvider).authStateChanges();
// });

// final signInWithGoogle = FutureProvider<User?>((ref) async {
//   final GoogleSignIn googleSignIn = ref.watch(googleSignInProvider);
//   final FirebaseAuth auth = ref.watch(authProvider);

//   try {
//     // Trigger Google Sign-In process
//     GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    
//     // If the user cancels the sign-in process, return null
//     if (googleUser == null) return null;

//     // Authenticate with Firebase using the GoogleSignInAccount credential
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
    
//     // Sign in to Firebase with the given credentials
//     UserCredential authResult = await auth.signInWithCredential(credential);

//     // Return the signed-in user
//     return authResult.user;
//   } catch (error) {
//     return null;
//   }
// });
