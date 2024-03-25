import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/farmer/crud_farmer/add_screen.dart';
import 'package:farmlynko/main.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
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
            'Marketplace',
            style: AppTextStyle.latoStyle(size: 15),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          color: AppColors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 3.5.h),
                height: 20.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue,
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(96, 0, 0, 0), BlendMode.darken),
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          "https://www.unlockfood.ca/EatRightOntario/media/Website-images-resized/How-to-store-fruit-to-keep-it-fresh-resized.jpg",
                        ))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total product added',
                      style: AppTextStyle.latoStyle(
                          size: 17, color: Colors.white),
                    ),
                    Text(
                      '3',
                      style: AppTextStyle.latoStyle(
                          size: 22, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 12.h,
                      height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  "https://www.unlockfood.ca/EatRightOntario/media/Website-images-resized/How-to-store-fruit-to-keep-it-fresh-resized.jpg"))),
                    ),
                    Gap(3.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Strawberry',
                            style: AppTextStyle.latoStyle(size: 12),
                          ),
                          Gap(1.h),
                          Text(
                            'Fruit',
                            style: AppTextStyle.latoStyle(size: 10),
                          ),
                          Gap(1.h),
                          Text(
                            'GHC 56.00',
                            style: AppTextStyle.latoStyle(size: 12),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          widthFactor: 0.1.h,
          heightFactor: 0.4.h,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            elevation: 0,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return const FarmAddScreen();
              })));
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
