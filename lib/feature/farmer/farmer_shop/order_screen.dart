import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../buyer/provider/order_detail.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the order details from the provider
    final orderList = ref.watch(orderListProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Order",
          style: TextStyle(color: Colors.black),
        ),
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
      body: orderList.isEmpty
          ? const Center(child: Text("ORDER SCREEN IS EMPTY"))
          : SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) => Card(
                        elevation: 3,
                        margin:
                            EdgeInsets.only(left: 2.h, right: 2.h, bottom: 3.h),
                        child: ExpansionTile(
                          iconColor: Colors.black,
                          title: Text(
                            "Order Number :${index + 1}",
                          ),
                          children: [
                            Text(
                                "Number of Items: ${orderList[index].numberOfItems}"),
                            const SizedBox(height: 16),
                            const Text("Item Names:"),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: orderList[index]
                                  .itemNames
                                  .map((name) => Text("- $name"))
                                  .toList(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                                "Total Amount: GHC ${orderList[index].totalAmount.toStringAsFixed(2)}"),
                            SizedBox(
                              height: 3.h,
                            )
                          ],
                        ),
                      )),
            ),
    );
  }
}
