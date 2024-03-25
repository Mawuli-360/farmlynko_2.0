import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialLaunch {
  SocialLaunch._();

  static Future<void> launchTelegram() async {
    String url = "https://t.me/+spVvbKhN3E8wYTI0";
    if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
      throw "Can not launch url";
    }
  }

  static void launchWhatsApp(String phoneNumber) async {
    String url = "https://wa.me/$phoneNumber";
    if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
      throw "Can not launch url";
    }
  }

  static void launchPhoneCall(String phoneNumber) async {
    Uri uri = Uri.parse("tel:$phoneNumber");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch url";
    }
  }

  static void launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch url";
    }
  }
}
