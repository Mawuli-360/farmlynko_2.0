import 'package:farmlynko/feature/farmer/farmer_menu_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_tab_screens.dart';
import 'package:farmlynko/main.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class FarmerMainScreen extends ConsumerWidget {
  const FarmerMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ZoomDrawer(
      controller: drawerController,
      mainScreenScale: 0.3,
      angle: 0,
      slideWidth: 250,
      showShadow: true,
      clipMainScreen: false,
      menuScreen: FarmerMenuScreen(
        controller: drawerController,
      ),
      mainScreen: const FarmerTabScreens(),
      menuBackgroundColor: AppColors.primaryColor,
      mainScreenTapClose: true,
    );
  }
}
