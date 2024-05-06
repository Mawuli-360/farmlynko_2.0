import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/product_model.dart';
import 'package:farmlynko/feature/buyer/provider/products_provider.dart';
import 'package:farmlynko/feature/buyer/ui/product_screen.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

class OfferScreen extends ConsumerStatefulWidget {
  const OfferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OfferScreenState();
}

class _OfferScreenState extends ConsumerState<OfferScreen> {
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
        centerTitle: true,
        title: Text(
          "Best Offers",
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 2.5.h, right: 2.5.h, top: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                    mainAxisSpacing: 2.h,
                                    childAspectRatio: 0.8,
                                    crossAxisSpacing: 2.h),
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
                    loading: () => const CircularProgressIndicator()))
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
            SizedBox(
              height: 17.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1.h),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
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
