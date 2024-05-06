import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/farmer/farmers_providers/fetch_product.dart';
import 'package:farmlynko/feature/farmer/farmers_crud_store/add_screen.dart';
import 'package:farmlynko/feature/farmer/farmers_crud_store/edit_screen.dart';
import 'package:farmlynko/feature/farmer/farmers_crud_store/farm_edit_screen.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:farmlynko/shared/widget/custom_app_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  Future<void> deleteProduct(String productId) async {
    try {
      // Get the product document from Cloud Firestore
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();

      // Get the image download URL from the product document
      String imageUrl = productSnapshot.get('imageUrl');

      // Delete the product document from Cloud Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();

      // Delete the product image from Firebase Storage
      Reference imageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await imageRef.delete();
    } catch (e) {
      showToast(context, 'Error deleting product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final countProduct = ref.watch(productCountProvider);
    final fetchProduct = ref.watch(fetchProductProvider);

    return Scaffold(
        appBar: const CustomAppBar(
          title: "Marketplace",
          isTitleCentered: true,
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
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(96, 0, 0, 0), BlendMode.darken),
                        fit: BoxFit.cover,
                        image: AppImages.oyingbo)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total product added',
                      style:
                          AppTextStyle.latoStyle(size: 17, color: Colors.white),
                    ),
                    Text(
                      countProduct.asData?.value.toString() ?? "0",
                      style:
                          AppTextStyle.latoStyle(size: 22, color: Colors.white),
                    ),
                  ],
                ),
              ),
              fetchProduct.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text("NO PRODUCTS"),
                      ),
                    );
                  }
                  return Expanded(
                      child: GridView.builder(
                          itemCount: data.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 2.h,
                            childAspectRatio: 0.094.h,
                          ),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Positioned(
                                    bottom: 0.15.h,
                                    left: 1.h,
                                    right: 1.h,
                                    child: Container(
                                      width: 38.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 160, 208, 181),
                                          borderRadius:
                                              BorderRadius.circular(1.h)),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 0.5.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name: ${data[index].name}",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Gap(0.5.h),
                                            Text(
                                                "Price: GHC ${data[index].price}"),
                                          ],
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  left: 1.h,
                                  right: 1.h,
                                  top: 0.5.h,
                                  child: Container(
                                    width: 38.w,
                                    height: 14.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                data[index].imageUrl),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(1.h)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 4.h,
                                    // width: 40.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => deleteProduct(
                                              data[index].productId),
                                          child: CircleAvatar(
                                            radius: 1.9.h,
                                            backgroundColor: Colors.white,
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        FarmEditScreen(
                                                            product:
                                                                data[index])));
                                          },
                                          child: CircleAvatar(
                                            radius: 1.9.h,
                                            backgroundColor: AppColors.white,
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }));
                },
                loading: () => Center(
                    child: SizedBox(
                  height: 12.h,
                  width: 12.h,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.ballClipRotateMultiple,
                  ),
                )),
                error: (error, stackTrace) => Expanded(
                  child: Center(
                    child: Text(error.toString()),
                  ),
                ),
              )
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
