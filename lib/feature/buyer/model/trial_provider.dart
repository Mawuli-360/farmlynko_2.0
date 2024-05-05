import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Assume you have a function to fetch the formatted text from Firebase
Future<String> fetchFormattedTextFromFirebase() async {
  // Your implementation to fetch the formatted text
  // Replace this with your actual implementation to fetch the formatted text from Firebase
  // E.g., using Firestore or Realtime Database
  await Future.delayed(const Duration(seconds: 2));
  return '<h1>This is a header</h1><p>This is a paragraph with <b>bold</b> text and <i>italic</i> text.</p>';
}

// Riverpod provider to fetch the formatted text
final formattedTextProvider = FutureProvider<String>((ref) {
  return fetchFormattedTextFromFirebase();
});



class FormattedTextPage extends ConsumerWidget {
  const FormattedTextPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use watch to access the formattedTextProvider's state
    final formattedTextAsyncValue = ref.watch(formattedTextProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formatted Text from Firebase'),
      ),
      body: formattedTextAsyncValue.when(
        data: (formattedText) {
          return SingleChildScrollView(
            child: Html(
              data: formattedText,
              style: {
                // Define any additional styles you want here
                'body': Style(fontSize: FontSize.medium),
                'li': Style(
                  fontSize: FontSize.medium,
                  fontWeight: FontWeight.bold,
                ),
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error loading formatted text: $error'),
        ),
      ),
    );
  }
}
