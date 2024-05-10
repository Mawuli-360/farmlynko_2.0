import 'package:farmlynko/feature/buyer/provider/user_provider.dart';
import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/feature/farmer/home_screen/presentation/widget/news_section.dart';
import 'package:farmlynko/feature/farmer/home_screen/presentation/widget/tip_section.dart';
import 'package:farmlynko/feature/farmer/home_screen/presentation/widget/trending_section.dart';
import 'package:farmlynko/feature/farmer/home_screen/presentation/widget/weather_section.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerHomeScreen extends ConsumerStatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends ConsumerState<FarmerHomeScreen> {
  String selectedValue = "Crop Protection";
  String query = "";

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDetailsProvider);
    return Scaffold(
      appBar: CustomAppBar(
          title: user != null
              ? "Welcome ${user.name}"
              : "Hi Farmer"),
      backgroundColor: AppColors.white,
      body: const SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TrendingSection(),
                TipSection(),
                NewsSection(),
                WeatherSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
