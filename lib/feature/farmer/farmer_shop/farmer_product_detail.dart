import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/provider/cart_provider.dart';
import 'package:farmlynko/feature/farmer/model/farmer_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class FarmerProductDetail extends ConsumerStatefulWidget {
  const FarmerProductDetail({super.key, required this.product});

  final FarmerProductModel product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerProductDetailState();
}

class _FarmerProductDetailState extends ConsumerState<FarmerProductDetail> {
  @override
  Widget build(BuildContext context) {
    final selectedAddOns = ref.watch(selectedAddOnsProvider);
    final randomAddOns = ref.watch(randomAddOnsProvider);

    // final searchQuery = ref.watch(searchQueryProvider.notifier).state;

    // Filter products based on the search query
    // final filteredProducts = randomAddOns.when(
    //   data: (data) => data.where((product) {
    //     final name = product.name.toLowerCase();
    //     final query = searchQuery.toLowerCase();
    //     return name.contains(query);
    //   }).toList(),
    //   error: (Object error, StackTrace stackTrace) {},
    //   loading: () {},
    // );
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
            height: 2.h,
            width: 2.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(1.h))),
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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 30.h,
                width: double.infinity,
                child: CachedNetworkImage(
                    imageUrl: widget.product.imageUrl,
                    placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 0.3.h,
                        )))),
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.2.h),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Price: GHC ${widget.product.price}",
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          ref
              .read(cartProvider.notifier)
              .addToCart(widget.product, selectedAddOns);
          showToast(context, "Product added to cart screen");
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 40, left: 100, right: 100),
          height: 60,
          decoration: const ShapeDecoration(
              color: Colors.green, shape: StadiumBorder()),
          child: Center(
              child: Text(
            "Add To Cart",
            style: TextStyle(fontSize: 13.sp, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
