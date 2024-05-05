import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farmlynko/feature/farmer/farmers_shop/store_screen.dart';
import 'package:farmlynko/feature/farmer/home_screen/presentation/farmer_home_screen.dart';
import 'package:farmlynko/feature/farmer/service/service_landing_screen.dart';
import 'package:farmlynko/feature/farmer/weather/weather_screen.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

class FarmerTabScreens extends ConsumerStatefulWidget {
  const FarmerTabScreens({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerTabScreensState();
}

class _FarmerTabScreensState extends ConsumerState<FarmerTabScreens> {
  final List<Widget> items = [
    Icon(Iconsax.home_2, size: 4.h, color: Colors.white),
    Icon(Iconsax.cloud, size: 4.h, color: Colors.white),
    Icon(Icons.handyman_outlined, size: 4.h, color: Colors.white),
    Icon(Iconsax.shop, size: 4.h, color: Colors.white),
  ];

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const FarmerHomeScreen(),
      const WeatherScreen(),
      const ServiceLandingScreen(),
      const StoreScreen()
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[currentPage],
      bottomNavigationBar: CurvedNavigationBar(
        color: AppColors.primaryColor,
        animationDuration: const Duration(milliseconds: 600),
        buttonBackgroundColor: AppColors.primaryColor,
        backgroundColor: AppColors.white,
        items: items,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
