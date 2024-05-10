import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/feature/farmer/model/weather_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

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
    print(place);

    final url = Uri.parse(
        "https://newton-hackthon.onrender.com/weather?long=${location.longitude}&lat=${location.latitude}");
    final response = await http.get(
      url,
      headers: {
        "accept": "application/json",
      },
    );

    ref.read(weatherCondition.notifier).state =
        weatherResponseModelFromJson(response.body).weather;

    ref.read(advice.notifier).state =
        weatherResponseModelFromJson(response.body).advice;

    return place;
  } on Exception {
    throw Exception("Could not get place name");
  }
});
