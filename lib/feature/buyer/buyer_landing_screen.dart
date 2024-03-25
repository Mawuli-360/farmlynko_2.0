import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuyerLandingScreen extends ConsumerStatefulWidget {
  const BuyerLandingScreen({super.key});

  @override
  ConsumerState<BuyerLandingScreen> createState() => _BuyerLandingScreenState();
}

class _BuyerLandingScreenState extends ConsumerState<BuyerLandingScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Colors.amber[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Buyer Landing Screen"),
          ElevatedButton(
            onPressed: () {
              ref.read(authServiceProvider.notifier).signOut();
            },
            child: const Text("Sign Out"),
          )
        ],
      ),
    ));
  }
}

class DailyScreen extends ConsumerWidget {
  const DailyScreen({super.key});




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Colors.red,
    );
  }
}




