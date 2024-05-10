import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/model/product_model.dart';
import 'package:farmlynko/feature/buyer/provider/products_provider.dart';
import 'package:farmlynko/feature/buyer/ui/product_screen.dart';
import 'package:farmlynko/feature/farmer/farmer_shop/farmer_product_detail.dart';
import 'package:farmlynko/feature/farmer/model/farmer_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

class FarmerSearchScreen extends ConsumerStatefulWidget {
  const FarmerSearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerSearchScreenState();
}

class _FarmerSearchScreenState extends ConsumerState<FarmerSearchScreen> {
  String _searchQuery = '';

  void _onSearchTextChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(filteredFarmerProductsProvider(_searchQuery));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Container(
          height: 5.h,
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            color: const Color.fromARGB(17, 76, 175, 79),
            borderRadius: BorderRadius.all(Radius.circular(10.h)),
            border: Border.all(color: Colors.green),
          ),
          child: TextField(
            autofocus: true,
            onChanged: _onSearchTextChanged,
            cursorColor: Colors.green,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0.5.h),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(1.h),
            height: 2.h,
            width: 2.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(1.h)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 0.7.h),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.green,
                size: 2.h,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _searchQuery.isNotEmpty
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 2.h),
                    child: AnimationLimiter(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: result.length,
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
                                      context: context, product: result[index]),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : const Center(
                    child: Text(
                      'Start typing to search',
                    ),
                  ),
          ),
        ],
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
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1.2.h),
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
            )),
            Container(
              padding: EdgeInsets.only(left: 0.6.h, top: 0.5.h),
              height: 10.h,
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
                  // Text(
                  //   product.category,
                  //   style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  // ),
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
