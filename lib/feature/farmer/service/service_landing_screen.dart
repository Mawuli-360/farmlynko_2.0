// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/farmer/service/category_detail_screen.dart';
import 'package:farmlynko/feature/farmer/service/cultivation_process_screen.dart';
import 'package:farmlynko/feature/farmer/service/hire_worker_screen.dart';
import 'package:farmlynko/feature/farmer/service/rent_detail_screen.dart';
import 'package:farmlynko/feature/farmer/service/service_product_detail_screen.dart';
import 'package:farmlynko/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';

class ServiceLandingScreen extends ConsumerStatefulWidget {
  const ServiceLandingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ServiceLandingScreen> createState() =>
      _ServiceLandingScreenState();
}

class _ServiceLandingScreenState extends ConsumerState<ServiceLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:
       AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.segment_rounded,
            color: AppColors.black,
            size: 24,
          ),
          onPressed: () {
            drawerController.toggle?.call();
          },
        ),
        title: Text(
          'Services',
          style: AppTextStyle.latoStyle(size: 15),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_sharp,
              color: AppColors.black,
              size: 24,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: GridView.builder(
                      itemCount: services(context).length,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return _ServiceCard(services(context)[index]);
                      })),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceData {
  final String title;
  final String image;
  final void Function() onTap;
  ServiceData({
    required this.title,
    required this.image,
    required this.onTap,
  });
}

List<ServiceData> services(BuildContext context) {
  return [
    ServiceData(
      title: 'Seeds',
      image:
          'https://www.tastingtable.com/img/gallery/common-mistakes-everyone-makes-with-beans/intro-1656424788.jpg',
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CategoryDetailScreen()));
      },
    ),
    ServiceData(
      title: 'Machinery',
      image:
          'https://www.agriculture.com/thmb/B-2q5mt0LpReuTbw4PQPaayaZIk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Tractors20for20sale20at20Cook20Auction-2000-f033f1283ab1498a93d3af41e663a4d4.jpg',
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const RentDetailScreen()));
      },
    ),
    ServiceData(
      title: 'Fertilizers',
      image:
          'https://piedmontmastergardeners.org/wp-content/uploads/2021/03/garden-shed-fertilizer-retail-637x320@2x.jpg',
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CategoryDetailScreen()));
      },
    ),
    ServiceData(
      title: 'Hire Worker',
      image:
          'https://content.fortune.com/wp-content/uploads/2020/04/Farm-Zuchinni-Harvest-Florida.jpg',
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const HireWorkerScreen()));
      },
    ),
    ServiceData(
      title: 'planting process',
      image:
          'https://preferredbynature.org/sites/default/files/inline-images/iStock-1001921102.jpg',
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const CultivationProcessScreen()));
      },
    ),
    ServiceData(
      title: 'Crop disease',
      image:
          'https://cdn.britannica.com/89/126689-004-D622CD2F/Potato-leaf-blight.jpg',
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CategoryDetailScreen()));
      },
    ),
  ];
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard(this.serviceData);

  final ServiceData serviceData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: serviceData.onTap,
      child: Container(
        width: 100,
        height: 165,
        decoration: BoxDecoration(
          color: Colors.green,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(serviceData.image),
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
