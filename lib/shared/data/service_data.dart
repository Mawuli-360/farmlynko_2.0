import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:farmlynko/feature/farmer/farmer_shop/farmer_shop_screen.dart';
import 'package:farmlynko/feature/farmer/service/presentation/service_inner_screens/cultivation_process_screen.dart';
import 'package:farmlynko/feature/farmer/service/presentation/service_inner_screens/hire_worker_screen.dart';
import 'package:farmlynko/feature/farmer/service/presentation/service_inner_screens/rent_detail_screen.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ServiceScreenData {
  ServiceScreenData._();

  static List<ServiceData> services(BuildContext context) {
    return [
      ServiceData(
        title: 'Machinery',
        image: AppImages.tractors,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const RentDetailScreen()));
        },
      ),
      ServiceData(
        title: 'Hire Worker',
        image: AppImages.labors,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const HireWorkerScreen()));
        },
      ),
      ServiceData(
        title: 'planting process',
        image: AppImages.plantRice,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const CultivationProcessScreen()));
        },
      ),
      ServiceData(
        title: 'Shop',
        image: AppImages.agroShop,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const FarmerShopScreen()));
        },
      ),
    ];
  }
}

class ServiceData {
  final String title;
  final AssetImage image;
  final void Function() onTap;
  ServiceData({
    required this.title,
    required this.image,
    required this.onTap,
  });
}

class ServiceCard extends StatelessWidget {
  const ServiceCard(this.serviceData, {required this.height, super.key});

  final ServiceData serviceData;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: serviceData.onTap,
      child: Container(
        width: 100,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: serviceData.image,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Align(
          alignment: const AlignmentDirectional(0.00, 1.00),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: BlurryContainer(
              borderRadius: BorderRadius.all(Radius.circular(1.h)),
              width: 150,
              height: 40,
              child: Center(
                child: Text(serviceData.title,
                    textAlign: TextAlign.center,
                    style:
                        AppTextStyle.latoStyle(size: 12, color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
