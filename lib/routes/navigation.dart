import 'package:farmlynko/feature/authentication/buyer_registration.dart';
import 'package:farmlynko/feature/authentication/registration_screen.dart';
import 'package:farmlynko/feature/authentication/waiting_screen.dart';
import 'package:farmlynko/feature/buyer/ui/bookmark_screen.dart';
import 'package:farmlynko/feature/buyer/ui/card_payment.dart';
import 'package:farmlynko/feature/buyer/ui/cart_screen.dart';
import 'package:farmlynko/feature/buyer/ui/change_password.dart';
import 'package:farmlynko/feature/buyer/ui/delivery_address_screen.dart';
import 'package:farmlynko/feature/buyer/ui/help_screen.dart';
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/login.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/reset_screen.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/sign_up_screen.dart';
import 'package:farmlynko/feature/buyer/ui/logins_screen/success_login.dart';
import 'package:farmlynko/feature/buyer/ui/mobile_money.dart';
import 'package:farmlynko/feature/buyer/ui/news_feed.dart';
import 'package:farmlynko/feature/buyer/ui/notication_screen.dart';
import 'package:farmlynko/feature/buyer/ui/offers_screen.dart';
import 'package:farmlynko/feature/buyer/ui/onboarding_screens.dart/onboarding_screen.dart';
import 'package:farmlynko/feature/buyer/ui/order_screen.dart';
import 'package:farmlynko/feature/buyer/ui/payment_method.dart';
import 'package:farmlynko/feature/buyer/ui/privacy_screen.dart';
import 'package:farmlynko/feature/buyer/ui/profile_screen.dart';
import 'package:farmlynko/feature/buyer/ui/rating_screen.dart';
import 'package:farmlynko/feature/buyer/ui/search_scren.dart';
import 'package:farmlynko/feature/buyer/ui/settings.dart';
import 'package:farmlynko/feature/buyer/ui/shop_screen.dart';
import 'package:farmlynko/feature/buyer/ui/successful_payment.dart';
import 'package:farmlynko/feature/buyer/ui/thanks_screen.dart';
import 'package:farmlynko/feature/buyer/ui/thanku_report.dart';
import 'package:farmlynko/feature/buyer/ui/welcome_screen.dart';
import 'package:farmlynko/feature/farmer/chat_ai/ai_assisstant_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
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
  static const String newsDetailsScreen = "/newsDetailsScreen";
  static const homeScreen = "/homeScreen";
  static const thankScreen = "/thank_screen";

  static const cropCare = "/cropcare_screen";
  static const shopScreen = "/shop_screen";
  static const rateScreen = "/rate_screen";
  static const cropCareDetailScreen = "/crop_care_detail_screen";
  static const deliveryAddressScreen = "/delivery_screen";
  static const diagnoseScreen = "/diagnose_screen";
  static const expertiseScreen = "/expertise_screen";
  static const newsFeedScreen = "/newsfeed_screen";
  static const newsDetailScreen = "/news_detail_screen";
  static const cartScreen = "/cart_screen";
  static const profileScreen = "/profile_screen";
  static const settingScreen = "/setting_screen";
  static const bookmarkScreen = "/bookmark_screen";
  static const cardPaymentScreen = "/cardPaymentScreen";
  static const mobileMoneyScreen = "/mobileMoneyScreen";

  static const searchScreen = "/searchScreen";

  static const changePasswordScreen = "/changePasswordScreen";
  static const helpScreen = "/helpScreen";
  static const notificationScreen = "/notificationScreen";
  static const orderScreen = "/orderScreen";
  static const paymentMethodScreen = "/paymentMethodScreen";
  static const privacyScreen = "/privacyScreen";
  static const successPaymentScreen = "/successPaymentScreen";
  static const reportAppreciationScreen = "/reportAppreciationScreen";
  // static const loginScreen = "/loginScreen";
  static const signUpScreen = "/signUpScreen";
  static const phoneVerificationScreen = "/phoneVerificationScreen";
  static const resetPassword = "/resetPassword";
  static const successAccountScreen = "/successAccountScreen";
  static const signInScreen = "/signInScreen";
  static const verificationScreen = "/verificationScreen";
  static const oonboardingScreen = "/onboardingScreen";

  static const resetScreen = "/resetScreen";
  static const splashScreen = "/splashScreen";
  static const offerScreen = "/offerScreen";
  static const welcomeScreen = "/welcomeScreen";
  static const successLoginScreen = "/successLoginScreen";

  static Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case farmerScreen:
        return MaterialPageRoute(builder: (_) => const FarmerMainScreen());
      case registrationScreen:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case buyerRegistrationScreen:
        return MaterialPageRoute(
            builder: (_) => const BuyerRegistrationScreen());
      case waitingScreen:
        return MaterialPageRoute(builder: (_) => const WaitingScreen());
      case assistantScreen:
        return MaterialPageRoute(builder: (_) => const AssistantScreen());
      case homeScreen:
        return openRoute(widget: const HomeScreen());
      case searchScreen:
        return openRoute(widget: const SearchScreen());
      case cardPaymentScreen:
        return openRoute(widget: const CardPayment());
      case shopScreen:
        return openRoute(widget: const ShopScreen());
      case rateScreen:
        return openRoute(widget: const RateScreen());
      case deliveryAddressScreen:
        return openRoute(widget: const DeliveryAddressScreen());
      case newsFeedScreen:
        return openRoute(widget: const NewsFeed());
      case cartScreen:
        return openRoute(widget: const CartScreen());
      case profileScreen:
        return openRoute(widget: const ProfileScreen());
      case orderScreen:
        return openRoute(widget: const OrderScreen());
      case settingScreen:
        return openRoute(widget: const SettingsScreen());
      case bookmarkScreen:
        return openRoute(widget: const BookmarkScreen());
      case changePasswordScreen:
        return openRoute(widget: const ChangePasswordScreen());
      case helpScreen:
        return openRoute(widget: const HelpScreen());
      case notificationScreen:
        return openRoute(widget: const NotificationScreen());
      case resetScreen:
        return openRoute(widget: const ResetPassword());
      case paymentMethodScreen:
        return openRoute(widget: const PaymentMethodScreen());
      case privacyScreen:
        return openRoute(widget: const PrivacyScreen());
      case successPaymentScreen:
        return openRoute(widget: const SuccessPayment());
      case reportAppreciationScreen:
        return openRoute(widget: const ReportAppreciation());
      case thankScreen:
        return openRoute(widget: const ThankScreen());
      // case loginScreen:
      //   return openRoute(widget: const LoginScreen());
      case mobileMoneyScreen:
        return openRoute(widget: const MobileMoney());
      case welcomeScreen:
        return openRoute(widget: const WelcomeScreen());
      case signUpScreen:
        return openRoute(widget: const SignUpScreen());
      case successAccountScreen:
        return openRoute(widget: const SuccessPayment());
      case successLoginScreen:
        return openRoute(widget: const SuccessLogin());
      case resetPassword:
        return openRoute(widget: const ResetPassword());
      case oonboardingScreen:
        return openRoute(widget: const OnboardingScreen());
      case offerScreen:
        return openRoute(widget: const OfferScreen());
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

  static openNewsDetailScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, newsDetailsScreen);
  }

  static openHomeScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, homeScreen);
  }

  static openCropCareScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, cropCare);
  }

  static openWelcomeScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, welcomeScreen);
  }

  static openShopScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, shopScreen);
  }

  static openSuccessLoginScreen({required BuildContext context}) {
    return Navigator.pushReplacementNamed(context, successLoginScreen);
  }

  static openRateScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, rateScreen);
  }

  static openCropScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, cropCareDetailScreen);
  }

  static openDeliveryScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, deliveryAddressScreen);
  }

  static openDiagnoseScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, diagnoseScreen);
  }

  static openSearchScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, searchScreen);
  }

  static openResetScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, resetPassword);
  }

  static openExpertiseScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, expertiseScreen);
  }

  static openNewsScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, newsFeedScreen);
  }

  // static openLoginScreen({required BuildContext context}) {
  //   return Navigator.pushNamed(context, loginScreen);
  // }

  // static openNewsDetailScreen({required BuildContext context}) {
  //   return Navigator.pushNamed(context, newsDetailScreen);
  // }

  static openCartScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, cartScreen);
  }

  static openMobileMoneyScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, mobileMoneyScreen);
  }

  static openProfileScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, profileScreen);
  }

  static openSettingScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, settingScreen);
  }

  static openbookmarkScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, bookmarkScreen);
  }

  static openofferScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, offerScreen);
  }

  static opencardPaymentScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, cardPaymentScreen);
  }

  static openchangePasswordScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, changePasswordScreen);
  }

  static openhelpScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, helpScreen);
  }

  static openOrderScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, orderScreen);
  }

  static opennotificationScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, notificationScreen);
  }

  static openThankScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, thankScreen);
  }

  static openorderScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, orderScreen);
  }

  static openpaymentMethodScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, paymentMethodScreen);
  }

  static openprivacyScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, privacyScreen);
  }

  static opensuccessPaymentScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, successPaymentScreen);
  }

  static openSignUpScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, signUpScreen);
  }

  static openreportAppreciationScreen({required BuildContext context}) {
    return Navigator.pushNamed(context, reportAppreciationScreen);
  }
}

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
