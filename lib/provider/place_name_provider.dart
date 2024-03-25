import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = FutureProvider<Position>((ref) async {
  try {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  } catch (e) {
    throw Exception("Could not get location");
  }
});

final placeNameProvider = FutureProvider<String>((ref) async {
  final location = ref.watch(locationProvider).value!;

  try {
    final placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    String place =
        "${placemarks[0].subAdministrativeArea!}, ${placemarks[0].country!}";

    return place;
  } on Exception {
    throw Exception("Could not get place name");
  }
});
