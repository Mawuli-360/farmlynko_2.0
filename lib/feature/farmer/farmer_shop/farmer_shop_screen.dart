import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/provider/cart_provider.dart';
import 'package:farmlynko/feature/buyer/provider/products_provider.dart';
import 'package:farmlynko/feature/farmer/farmer_main_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_shop/farmer_product_detail.dart';
import 'package:farmlynko/feature/farmer/model/farmer_product_model.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class FarmerShopScreen extends ConsumerStatefulWidget {
  const FarmerShopScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerShopScreenState();
}

class _FarmerShopScreenState extends ConsumerState<FarmerShopScreen> {
  int currentChip = 0;
  int currentPage = 0;
  String selectedValue = "all";
  String query = "";

  bool onSearchSelect = false;

  List<String> categoryName = [
    "All",
    "Seeds",
    "Crop Nutrient",
    "Crop Protection"
  ];

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(selectedProductsProvider(selectedValue));
    final cartItems = ref.watch(cartProvider);
    final itemCount = cartItems.length;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const FarmerMainScreen()));
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigation.openCartScreen(context: context);
            },
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -2, end: 3),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeContent: Text(
                '$itemCount',
                style: const TextStyle(color: Colors.white),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 8.h,
                  height: 4.h,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: AppImages.cart,
                ),
              ),
            ),
          )
        ],
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
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
            SizedBox(
                height: 4.5.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final item = categoryName[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentChip = index;
                            selectedValue = item;
                            // print(selectedValue);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 0),
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          decoration: BoxDecoration(
                              color: currentChip == index
                                  ? const Color.fromARGB(204, 41, 88, 10)
                                  : const Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.h))),
                          child: Text(
                            categoryName[index],
                            style: TextStyle(
                                fontSize: 12.sp,
                                height: 2,
                                color: currentChip == index
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        ),
                      );
                    })),
            SizedBox(
              height: 3.h,
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
      {required BuildContext context, required FarmerProductModel product}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FarmerProductDetail(
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
              height: 13.h,
              width: double.infinity,
              // color: Colors.yellow,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 181, 255, 183),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 0.3.h,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 0.6.h, top: 0.5.h),
              height: 9.h,
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
                    product.category,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
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
