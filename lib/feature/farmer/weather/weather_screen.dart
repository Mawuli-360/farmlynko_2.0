import 'dart:convert';

import 'package:farmlynko/main.dart';
import 'package:farmlynko/provider/place_name_provider.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  late DateTime startDate;
  late DateTime endDate;
  bool isLoading = false;
  String soilSummary = "";
  String windSummary = "";
  String chanceOfRain = "";
  String temperatureSummary = "";
  int selectedValue = 0;
  DateTime? selectedDate;
  double windSpeed = 0.0;
  double chanceOfRainValue = 0.0;
  double soilTemp = 0.0;
  double soilMois = 0.0;

  @override
  void initState() {
    super.initState();
    updateDates();
    getDailyForecast();
  }

  void getDailyForecast() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
        Uri.parse("https://b2b.ignitia.se/api/iskaplusbr-mvp/forecast"),
        headers: {
          "Accept": "*/*",
          'Content-Type': 'application/json',
          "auth-key": "bVCOiXo1ECDckt7yIQOHmN6r9ZXKBN9v",
        },
        body: jsonEncode({
          'lat': ref.read(locationProvider).value?.latitude.toString() ??
              double.parse("5.65178"),
          'lon': ref.read(locationProvider).value?.longitude.toString() ??
              double.parse("-0.25817"),
          "date_interval": {
            "start": DateFormat('yyyy-MM-dd').format(selectedDate ?? startDate),
            "end": DateFormat('yyyy-MM-dd').format(endDate),
          }
        }));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data[DateFormat('yyyy-MM-dd').format(startDate)]);
      print(data[DateFormat('yyyy-MM-dd').format(startDate)]["daily"]["fcat"]);
      setState(() {
        isLoading = false;
        chanceOfRain = "it is safe today because it won't rain";
        windSummary = " It will not rain today";
        soilSummary = "The soil is healthy";
        temperatureSummary = "The temperature is normal";
        windSpeed = data[DateFormat('yyyy-MM-dd').format(startDate)]["daily"]
            ["pwindgust"];
        soilMois = data[DateFormat('yyyy-MM-dd').format(startDate)]["daily"]
            ["soil_moist_1"];
        soilTemp = data[DateFormat('yyyy-MM-dd').format(startDate)]["daily"]
            ["soil_temp_1"];
        chanceOfRainValue = data[DateFormat('yyyy-MM-dd').format(startDate)]
            ["daily"]["rainfall"];
      });
    }
  }

  void handleDateChange(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
    getDailyForecast();
  }

  void updateDates() {
    final now = DateTime.now();
    startDate = DateTime(now.year, now.month, now.day);
    endDate = startDate.add(const Duration(days: 6));
    setState(() {});
  }

  void updateDatesOnNextDay() {
    startDate = startDate.add(const Duration(days: 1));
    endDate = startDate.add(const Duration(days: 6));
  }

  void handlePress() {
    setState(() {
      updateDatesOnNextDay();
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeName = ref.watch(placeNameProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Weather", style: AppTextStyle.latoStyle(size: 15)),
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.segment_rounded,
                color: AppColors.black,
              ),
              onPressed: () {
                drawerController.toggle!();
              })),
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primaryColor,
          ),
          Positioned(
            top: 4.h,
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 6.h,
                ),
                Column(
                  children: [
                    Text(
                      "Your Current Location:",
                      style: AppTextStyle.latoStyle(
                          size: 12, color: AppColors.white),
                    ),
                    placeName.when(
                        data: (data) => Text(
                              " $data",
                              style: AppTextStyle.latoStyle(
                                  size: 12, color: AppColors.white),
                            ),
                        error: (s, t) => const Text("Error"),
                        loading: () => const LoadingIndicator(
                            indicatorType: Indicator.ballBeat)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 65.h,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: SizedBox(
                      height: 6.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          final currentDate =
                              startDate.add(Duration(days: index));
                          final formattedDate =
                              DateFormat('yyyy-MM-dd').format(currentDate);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedValue = index;
                              });
                              handleDateChange(currentDate);
                            },
                            child: SizedBox(
                              width: 100,
                              child: Card(
                                color: index == selectedValue
                                    ? AppColors.primaryColor
                                    : AppColors.white,
                                child: Center(
                                  child: Text(
                                    index == 0 ? "Today" : formattedDate,
                                    style: AppTextStyle.latoStyle(
                                        size: 1.h,
                                        color: index == selectedValue
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? Center(
                            child: SizedBox(
                              height: 4.h,
                              width: 4.h,
                              child: const LoadingIndicator(
                                  indicatorType: Indicator.ballClipRotate),
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Gap(3.h),
                                Container(
                                  height: 12.h,
                                  width: 90.w,
                                  padding: EdgeInsets.all(0.8.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10.h,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                width: 4.h,
                                                child: Image.asset(
                                                    "assets/images/Wind.png")),
                                            Text("$windSpeed km/h"),
                                            const Text("Wind speed")
                                          ],
                                        ),
                                      ),
                                      Gap(1.h),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0.5.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Wind speed of ${windSpeed}km/h is good for spraying",
                                              style: AppTextStyle.latoStyle(
                                                  size: 10,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(2.h),
                                Container(
                                  height: 12.h,
                                  width: 90.w,
                                  padding: EdgeInsets.all(0.8.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10.h,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                width: 4.h,
                                                child: Image.asset(
                                                    "assets/images/drop.png")),
                                            Text("$chanceOfRainValue %"),
                                            const Text("Chance of\nrain")
                                          ],
                                        ),
                                      ),
                                      Gap(1.h),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0.5.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              windSummary,
                                              style: AppTextStyle.latoStyle(
                                                  size: 10,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(2.h),
                                Container(
                                  height: 12.h,
                                  width: 90.w,
                                  padding: EdgeInsets.all(0.8.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10.h,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                width: 4.h,
                                                child: Image.asset(
                                                    "assets/images/Soil.png")),
                                            Text("$soilTemp C"),
                                            const Text("Soil temp")
                                          ],
                                        ),
                                      ),
                                      Gap(1.h),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0.5.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              temperatureSummary,
                                              style: AppTextStyle.latoStyle(
                                                  size: 10,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(2.h),
                                Container(
                                  height: 12.h,
                                  width: 90.w,
                                  padding: EdgeInsets.all(0.8.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10.h,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                width: 4.h,
                                                child: Image.asset(
                                                    "assets/images/Moisture.png")),
                                            Text("$soilMois %"),
                                            const Text("Soil mois.")
                                          ],
                                        ),
                                      ),
                                      Gap(1.h),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0.5.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              soilSummary,
                                              style: AppTextStyle.latoStyle(
                                                  size: 10,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
