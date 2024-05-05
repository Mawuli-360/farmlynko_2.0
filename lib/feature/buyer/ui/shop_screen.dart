import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/product_model.dart';
import 'package:farmlynko/feature/buyer/provider/cart_provider.dart';
import 'package:farmlynko/feature/buyer/provider/products_provider.dart';
import 'package:farmlynko/feature/buyer/ui/product_screen.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  int currentChip = 0;
  int currentPage = 0;
  String selectedValue = "all";
  String query = "";

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(fetchAllProductProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(1.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.green)),
            child: Center(
              child: AppImages.back,
            ),
          ),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       Navigation.openCartScreen(context: context);
        //     },
        //     child: badges.Badge(
        //       position: badges.BadgePosition.topEnd(top: -2, end: 3),
        //       badgeAnimation: const badges.BadgeAnimation.rotation(
        //         animationDuration: Duration(seconds: 1),
        //         colorChangeAnimationDuration: Duration(seconds: 1),
        //         loopAnimation: false,
        //         curve: Curves.fastOutSlowIn,
        //         colorChangeAnimationCurve: Curves.easeInCubic,
        //       ),
        //       badgeContent: Text(
        //         '$itemCount',
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //       child: Align(
        //         alignment: Alignment.center,
        //         child: Container(
        //           width: 8.h,
        //           height: 4.h,
        //           decoration: const BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.all(Radius.circular(10))),
        //           child: AppImages.cart,
        //         ),
        //       ),
        //     ),
        //   )
        // ],
        centerTitle: true,
        title: Text(
          "Shop",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 2.5.h, right: 2.5.h, top: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigation.openSearchScreen(context: context);
              },
              child: Container(
                height: 5.h,
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(17, 76, 175, 79),
                    borderRadius: BorderRadius.all(Radius.circular(10.h)),
                    border: Border.all(color: Colors.green)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "eg: Rice",
                      style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
                    ),
                    const Icon(
                      Icons.search,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
                child: productList.when(
                    data: (data) {
                      return AnimationLimiter(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5.h,
                                    childAspectRatio: 0.9,
                                    crossAxisSpacing: 1.h),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: 2,
                                duration: const Duration(milliseconds: 700),
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: _buildBestProductItem(
                                        context: context, product: data[index]),
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                    error: (error, st) => Text(error.toString()),
                    loading: () =>
                        const Center(child: CircularProgressIndicator())))
          ],
        ),
      ),
    );
  }

  Widget _buildBestProductItem(
      {required BuildContext context, required ProductModel product}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(
                      product: product,
                    )));
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(54, 202, 247, 219),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Container(
              height: 14.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 181, 255, 183),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1.h),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 0.3.h,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 0.6.h, top: 0.5.h),
              height: 8.h,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    "GHC ${product.price}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF138F17),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
