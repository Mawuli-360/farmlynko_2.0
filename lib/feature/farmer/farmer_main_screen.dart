import 'package:farmlynko/feature/farmer/farmer_menu_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_tab_screens.dart';
import 'package:farmlynko/main.dart';
import 'package:farmlynko/service/permission_handle.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sizer/sizer.dart';

class FarmerMainScreen extends ConsumerStatefulWidget {
  const FarmerMainScreen({super.key});

  @override
  ConsumerState<FarmerMainScreen> createState() => _FarmerMainScreenState();
}

class _FarmerMainScreenState extends ConsumerState<FarmerMainScreen> {
  @override
  void initState() {
    super.initState();
    PermissionHandle.requestPermissions(context);
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: drawerController,
      mainScreenScale: 0.3,
      angle: 0,
      slideWidth: 70.w,
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
