import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/authentication/provider/authentication_provider.dart';
import 'package:farmlynko/feature/farmer/crud_farmer/edit_screen.dart';
import 'package:farmlynko/feature/farmer/farmers_providers/fetch_product.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';

final productDetailsProvider =
    FutureProvider.family<DocumentSnapshot?, String>((ref, productId) async {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final productDoc =
      await firestore.collection('products').doc(productId).get();
  return productDoc.exists ? productDoc : null;
});

class FarmerLandingScreen extends ConsumerWidget {
  const FarmerLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCount = ref.watch(productCountProvider).value ?? 0;
    final fetchProduct = ref.watch(fetchProductProvider);

    Future<void> deleteProductFromFirestore(String productId) async {
      final firestore = ref.watch(firebaseFirestoreProvider);

      try {
        // Delete the document using its ID
        await firestore.collection('products').doc(productId).delete();
        Fluttertoast.showToast(msg: "Product deleted successfully");
      } catch (e) {
        Fluttertoast.showToast(msg: "Failed to delete product: $e");
      }
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigation.navigateTo(Navigation.farmAddProductScreen);
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          width: double.infinity,
          color: Colors.amber[200],
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Farmer Landing Screen"),
                Container(
                  height: 80,
                  width: 80,
                  color: const Color.fromARGB(255, 248, 248, 248),
                  child: Center(child: Text("$productCount")),
                ),
                Container(
                  height: 400,
                  color: const Color.fromARGB(255, 189, 184, 184),
                  child: fetchProduct.when(data: (data) {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 80,
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: data[index].image,
                                  ),
                                ),
                                title: Text(data[index].name),
                                trailing: IconButton(
                                    onPressed: () {
                                      final productDetails = ref.watch(
                                          productDetailsProvider(
                                              data[index].id));
                                      if (productDetails.value != null) {
                                        final product = productDetails.value!;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditProductScreen(product),
                                          ),
                                        );
                                      } else if (productDetails.error != null) {
                                        print("hellllllllllllllll");
                                      }
                                      print("data[index].userId");
                                    },
                                    icon: const Icon(Icons.edit)),
                              ),
                            ),
                          );
                        });
                  }, error: (Object error, StackTrace stackTrace) {
                    return null;
                  }, loading: () {
                    return const LoadingIndicator(
                      indicatorType: Indicator.ballClipRotateMultiple,
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(authServiceProvider.notifier).signOut();
                  },
                  child: const Text("Sign Out"),
                )
              ],
            ),
          ),
        ));
  }
}
