import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/feature/farmer/model/weather_response_model.dart';
import 'package:farmlynko/provider/place_name_provider.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:farmlynko/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final placeName = ref.watch(placeNameProvider);
    final adviceWeather = ref.watch(advice);
    final weatherTips = ref.watch(weatherCondition);
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Weather",
        isTitleCentered: true,
      ),
      backgroundColor: AppColors.white,
      body: placeName.hasValue
          ? Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                ),
                Positioned(
                  top: 4.h,
                  child: Row(
                    children: [
                      Gap(2.h),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 6.h,
                      ),
                      Gap(2.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Current Location:",
                            style: AppTextStyle.latoStyle(
                                size: 12, color: AppColors.white),
                          ),
                          Text(
                            placeName.requireValue,
                            style: TextStyle(
                                color: AppColors.white, fontSize: 12.sp),
                          )
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
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(3.h))),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.h),
                              child: Column(
                                children: [
                                  Gap(3.h),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text:
                                            "Unlock the power of weather wisdom on ",
                                        style: AppTextStyle.latoStyle(
                                            size: 12,
                                            fontWeight: FontWeight.normal,
                                            color: const Color.fromARGB(
                                                148, 0, 0, 0)),
                                        children: const [
                                          TextSpan(
                                            text: "Farmlynco,",
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text:
                                                " where every forecast becomes your guiding light",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                  Gap(2.h),
                                  Container(
                                    padding: EdgeInsets.all(1.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    child: Text(
                                      weatherTips,
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ),
                                  Gap(2.h),
                                  Container(
                                    padding: EdgeInsets.all(1.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    child: Text(
                                      adviceWeather,
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ),
                                  Gap(3.h)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/animation/null.json",
                      height: 30.h, width: 30.h),
                  Text(
                    "No Location Found",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Gap(2.h),
                  OutlinedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await Geolocator.checkPermission();
                          await Geolocator.requestPermission();
                          final position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );
                          final placemarks = await placemarkFromCoordinates(
                            position.latitude,
                            position.longitude,
                          );
                          String place =
                              "${placemarks[0].subAdministrativeArea!}, ${placemarks[0].country!}";
                          print(place);

                          final url = Uri.parse(
                              "https://newton-hackthon.onrender.com/weather?long=${position.longitude}&lat=${position.latitude}");
                          final response = await http.get(
                            url,
                            headers: {
                              "accept": "application/json",
                            },
                          );

                          print(response.body);

                          ref.read(weatherCondition.notifier).state =
                              weatherResponseModelFromJson(response.body)
                                  .weather;

                          ref.read(advice.notifier).state =
                              weatherResponseModelFromJson(response.body)
                                  .advice;
                          setState(() {
                            isLoading = false;
                          });
                        } on Exception {
                          throw Exception("Could not get place name");
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Retry Location",
                              style: TextStyle(color: AppColors.primaryColor),
                            ))
                ],
              ),
            ),
    );
  }
}
