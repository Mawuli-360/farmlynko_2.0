import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeData {
  HomeData._();

  static List<CatData> category({required BuildContext context}) {
    return [
      CatData(
          title: "Shop",
          image: AppImages.shoppingCart,
          onTap: () {
            Navigation.openShopScreen(context: context);
          }),
      CatData(
          title: "Best Offers",
          image: AppImages.diamond,
          onTap: () {
            Navigation.openofferScreen(context: context);
          }),
      CatData(
          title: "Rate Us",
          image: AppImages.star,
          onTap: () {
            Navigation.openRateScreen(context: context);
          }),
    ];
  }

  static List<MenuData> menuData({required BuildContext context}) {
    return [
      MenuData(
          title: "My Profile",
          icon: Icons.person,
          onTap: () {
            Navigator.of(context).pop();
            Navigation.openProfileScreen(context: context);
          }),
      MenuData(
          title: "Payment Methods",
          icon: Icons.payment,
          onTap: () {
            Navigator.of(context).pop();
            Navigation.openpaymentMethodScreen(context: context);
          }),
      MenuData(
          title: "Settings",
          icon: Icons.settings,
          onTap: () {
            Navigator.of(context).pop();
            Navigation.openSettingScreen(context: context);
          }),
      MenuData(
          title: "Bookmarks",
          icon: Icons.bookmark,
          onTap: () {
            Navigator.of(context).pop();
            Navigation.openbookmarkScreen(context: context);
          }),
    ];
  }

  static List<SettingData> settingData({required BuildContext context}) {
    return [
      SettingData(
          title: "Change Password",
          onTap: () {
            Navigation.openchangePasswordScreen(context: context);
          }),
      SettingData(
          title: "Notification",
          onTap: () {
            Navigation.opennotificationScreen(context: context);
          }),
      SettingData(
          title: "Privacy & Policy",
          onTap: () {
            Navigation.openprivacyScreen(context: context);
          }),
      SettingData(
          title: "Help Center",
          onTap: () {
            Navigation.openhelpScreen(context: context);
          }),
      SettingData(
          title: "Rate Us",
          onTap: () {
            Navigation.openRateScreen(context: context);
          }),
    ];
  }

  static List<NotificationData> notificationData({required bool value}) {
    return [
      NotificationData("Allow Notification",
          "Allow us to send you a notification on news update", value)
    ];
  }

  static List<PaymentData> paymentData({required BuildContext context}) {
    return [
      PaymentData(
          text: "Mobile Money",
          onTap: () {
            Navigation.openMobileMoneyScreen(context: context);
          }),
      PaymentData(
          text: "Credit / Debit Card",
          onTap: () {
            Navigation.opencardPaymentScreen(context: context);
          }),
    ];
  }

  static List<PageViewData> pageViewnData() {
    return [
      PageViewData(
          image: AppImages.payment,
          title: "Farmily Market",
          subtitle:
              "Your one-stop farming shop for high-quality\nsupplies and equipment.Shop smart,grow\nsmart."),
      PageViewData(
          image: AppImages.undrawwelcoming,
          title: "Farmily Learn",
          subtitle:
              "Essential farming education-learn,\napply, and thrive with expert-guided\ntutorials and resources."),
      PageViewData(
          image: AppImages.undrawjoin,
          title: "Farmily Pro Tips",
          subtitle:
              "Unlock farming potential - expert insights\nand innovative techniques for higher\nyields and sustainable practices."),
    ];
  }
}

class Network {
  final String name;

  Network(this.name);
}

class CatData {
  final String title;
  final SvgPicture image;
  final VoidCallback onTap;

  CatData({required this.title, required this.image, required this.onTap});
}

class MenuData {
  final String title;
  final IconData icon;
  final void Function() onTap;

  MenuData({required this.title, required this.icon, required this.onTap});
}

class SettingData {
  final String title;
  final void Function() onTap;

  SettingData({required this.title, required this.onTap});
}

class NotificationData {
  final String title;
  final String subtitle;
  final bool value;

  NotificationData(this.title, this.subtitle, this.value);
}

class PageViewData {
  final AssetImage image;
  final String title;
  final String subtitle;

  PageViewData(
      {required this.image, required this.title, required this.subtitle});
}

class PaymentData {
  final String text;
  final VoidCallback onTap;

  PaymentData({
    required this.text,
    required this.onTap,
  });
}
