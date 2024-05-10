import 'package:farmlynko/provider/place_name_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandle {
  PermissionHandle._();

  static Future<void> requestPermissions(
      BuildContext context, WidgetRef ref) async {
    // Request location and microphone permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.microphone,
      Permission.camera,
      Permission.photos
    ].request();

    // Check if permissions are granted
    if (statuses[Permission.location] == PermissionStatus.granted &&
        statuses[Permission.microphone] == PermissionStatus.granted) {
      ref.watch(placeNameProvider);
    } else {
      // Permissions denied or never requested
      showPermissionDeniedDialog(context);
    }
  }

  static void showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
              'This app requires location and microphone permissions to function properly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open App Settings'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
