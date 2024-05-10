import 'dart:convert';

WeatherResponseModel weatherResponseModelFromJson(String str) =>
    WeatherResponseModel.fromJson(json.decode(str));

String weatherResponseModelToJson(WeatherResponseModel data) =>
    json.encode(data.toJson());

class WeatherResponseModel {
  final String weather;
  final String advice;

  WeatherResponseModel({
    required this.weather,
    required this.advice,
  });

  WeatherResponseModel copyWith({
    String? weather,
    String? advice,
  }) =>
      WeatherResponseModel(
        weather: weather ?? this.weather,
        advice: advice ?? this.advice,
      );

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      WeatherResponseModel(
        weather: json["weather"],
        advice: json["Advice"],
      );

  Map<String, dynamic> toJson() => {
        "weather": weather,
        "Advice": advice,
      };
}
