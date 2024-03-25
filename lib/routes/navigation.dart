import 'package:farmlynko/feature/authentication/auth_screen.dart';
import 'package:farmlynko/feature/authentication/buyer_registration.dart';
import 'package:farmlynko/feature/authentication/farmer_registration.dart';
import 'package:farmlynko/feature/authentication/registration_screen.dart';
import 'package:farmlynko/feature/authentication/waiting_screen.dart';
import 'package:farmlynko/feature/buyer/buyer_landing_screen.dart';
import 'package:farmlynko/feature/farmer/chat_ai/ai_assisstant_screen.dart';
import 'package:farmlynko/feature/farmer/crud_farmer/farmer_add_product.dart';
import 'package:farmlynko/feature/farmer/farmer_landing_screen.dart';
import 'package:farmlynko/shared/components/page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Navigation {
  Navigation._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String loginScreen = "/loginScreen";
  static const String buyerScreen = "/buyerScreen";
  static const String farmerScreen = "/farmerScreen";
  static const String registrationScreen = "/registrationScreen";
  static const String farmerRegistrationScreen = "/farmerRegistrationScreen";
  static const String buyerRegistrationScreen = "/buyerRegistrationScreen";
  static const String waitingScreen = "/waitingScreen";
  static const String farmAddProductScreen = "/farmAddProductScreen";
  static const String assistantScreen = "/assistantScreen";

  static Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case buyerScreen:
        return MaterialPageRoute(builder: (_) => const BuyerLandingScreen());
      case farmerScreen:
        return MaterialPageRoute(builder: (_) => const FarmerLandingScreen());
      case registrationScreen:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case farmerRegistrationScreen:
        return MaterialPageRoute(
            builder: (_) => const FarmerRegistrationScreen());
      case buyerRegistrationScreen:
        return MaterialPageRoute(
            builder: (_) => const BuyerRegistrationScreen());
      case waitingScreen:
        return MaterialPageRoute(builder: (_) => const WaitingScreen());
      case farmAddProductScreen:
        return MaterialPageRoute(
            builder: (_) => const FarmerAddProductScreen());
      case assistantScreen:
        return MaterialPageRoute(builder: (_) => const AssistantScreen());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }

  static openLoginScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, loginScreen);
  }

  static openRoute({required Widget widget}) {
    return SlidePageRoute(child: widget);
  }

  static openBuyerScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, buyerScreen);
  }

  static openRegistrationScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, registrationScreen);
  }

  static openBuyerRegistrationScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, buyerRegistrationScreen);
  }

  static openFarmerRegistrationScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, farmerRegistrationScreen);
  }

  static openAssistantScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, assistantScreen);
  }
}

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
