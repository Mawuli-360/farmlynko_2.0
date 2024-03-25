import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiagnoseDiseaseScreen extends ConsumerWidget {
  const DiagnoseDiseaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
            color: Colors.amber[200],
            child: const Center(
              child: Text("Diagnose Disease"),
            )));
  }
}
