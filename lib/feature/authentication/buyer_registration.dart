import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
