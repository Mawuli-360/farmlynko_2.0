import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmlynko/feature/buyer/provider/cart_provider.dart';
import 'package:farmlynko/feature/buyer/ui/home_screen.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:sizer/sizer.dart';
import 'package:tasty_toast/tasty_toast.dart';

import '../provider/order_detail.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    int numberOfItems = cart.fold(0, (sum, item) => sum + item.quantity);

    // Calculate the subtotal
    double subtotal =
        cart.fold(0, (sum, item) => sum + (int.parse(item.product.price) * item.quantity));

    // Calculate the tax & fees (assuming it's 5% of the subtotal)
    double taxAndFees = 5;

    // Calculate the grand total
    double grandTotal =
        subtotal + taxAndFees + 20; // Assuming delivery fee is GHC 20

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
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
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Expanded(
                flex: 2,
                child: cart.isEmpty
                    ? const Center(
                        child: Text("CART IS EMPTY"),
                      )
                    : ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) => _buildCartItem(
                            item: cart[index], ref: ref, context: context))),
            Expanded(
                child: Container(
              // color: Colors.yellow,
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      Text("GHC ${subtotal.toStringAsFixed(2)}")
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tax & Fees",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      const Text("GHC 5")
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      const Text("GHC 20")
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      Text("GHC ${grandTotal.toStringAsFixed(2)}")
                    ],
                  ),
                  const Divider(),
                ],
              ),
            )),
          ],
        ),
      )),
      bottomNavigationBar: CustomButton(
        title: "BUY NOW",
        onTap: () {
          final orderDetails = OrderDetails(
            numberOfItems: numberOfItems,
            itemNames: cart.map((item) => item.product.name).toList(),
            totalAmount: grandTotal,
          );

          ref.read(orderListProvider.notifier).addOrder(orderDetails);
          ref.read(cartProvider).clear();

          PayWithPayStack().now(
              context: context,
              secretKey: "sk_test_648a8e882ce704e4d8b7bb228c80acaeeb24b1fc",
              customerEmail: FirebaseAuth.instance.currentUser!.email!,
              callbackUrl: "google.com",
              reference: DateTime.now().microsecondsSinceEpoch.toString(),
              currency: "GHS",
              amount: (grandTotal * 100).toString(),
              transactionCompleted: () {
                Timer(const Duration(milliseconds: 300), () {
                  Navigation.openMobileMoneyScreen(context: context);
                });
                ref.read(cartProvider).clear();
              },
              transactionNotCompleted: () {
                ref.read(cartProvider).clear();
              });
        },
      ),
    );
  }

  Widget _buildCartItem(
      {required CartItem item,
      required WidgetRef ref,
      required BuildContext context}) {
    void increaseQuantity() {
      ref
          .read(cartProvider.notifier)
          .updateCartItemQuantity(item.product, item.quantity + 1);
    }

    void decreaseQuantity() {
      if (item.quantity > 1) {
        ref
            .read(cartProvider.notifier)
            .updateCartItemQuantity(item.product, item.quantity - 1);
      }
    }

    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 1.h),
        height: 18.h,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(1.h),
            height: 18.h,
            child: Row(children: [
              Expanded(
                  child: CachedNetworkImage(
                imageUrl: item.product.imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 0.3.h,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          item.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        // Text(
                        //   item.product.category,
                        //   style: TextStyle(fontSize: 13.sp),
                        // ),
                        SizedBox(height: 1.h),
                        Text(
                          "GHC ${item.product.price}",
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.green),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 1.h),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(cartProvider.notifier)
                            .removeFromCart(item.product);
                        showToast(context, "Product remove from cart screen");
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      )),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          decreaseQuantity();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              color: Colors.white,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Text("${item.quantity}"),
                      GestureDetector(
                        onTap: () {
                          increaseQuantity();
                          // print("object");
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
            ]),
          ),
        ));
  }
}
