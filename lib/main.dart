import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:farmlynko/firebase_options.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String initialRoute = await checkCurrentUser();

  await dotenv.load();
  runApp(ProviderScope(
      child: MyApp(
    initialRoute: initialRoute,
  )));
}

final drawerController = ZoomDrawerController();

Future<String> checkCurrentUser() async {
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
          return Navigation.farmerScreen;
        } else if (role == 'Buyer') {
          return Navigation.buyerScreen;
        }
      }
    }
    return Navigation.loginScreen;
  } catch (e) {
    // print('Error: $e');
    return Navigation.loginScreen;
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
    required this.initialRoute,
  });

  final String initialRoute;

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: const FarmerMainScreen(),

        // initialRoute: widget.initialRoute,
        // navigatorKey: Navigation.navigatorKey,
        // onGenerateRoute: Navigation.onGenerateRoute,
      );
    });
  }
}
