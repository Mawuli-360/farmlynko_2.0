import 'package:farmlynko/feature/farmer/farmer_menu_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_tab_screens.dart';
import 'package:farmlynko/feature/farmer/model/weather_response_model.dart';
import 'package:farmlynko/main.dart';
import 'package:farmlynko/provider/place_name_provider.dart';
import 'package:farmlynko/service/permission_handle.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';
import 'package:http/http.dart' as http;

final placeName = StateProvider<String>((ref) => '');
final advice = StateProvider<String>((ref) => '');
final weatherCondition = StateProvider<String>((ref) => '');
final isLoadingWeather = StateProvider<bool>((ref) => false);

class FarmerMainScreen extends ConsumerStatefulWidget {
  const FarmerMainScreen({super.key});

  @override
  ConsumerState<FarmerMainScreen> createState() => _FarmerMainScreenState();
}

class _FarmerMainScreenState extends ConsumerState<FarmerMainScreen> {
  @override
  void initState() {
    super.initState();
    PermissionHandle.requestPermissions(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(placeNameProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("NO"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: const Text("YES"),
              ),
            ],
          ),
        );
      },
      child: ZoomDrawer(
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
      ),
    );
  }
}
