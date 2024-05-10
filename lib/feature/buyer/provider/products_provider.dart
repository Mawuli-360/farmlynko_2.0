import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/buyer/model/product_model.dart';
import 'package:farmlynko/feature/buyer/provider/firebase_firestore.dart';
import 'package:farmlynko/feature/farmer/model/farmer_product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchSomeProductProvider = StreamProvider<List<ProductModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final collection = firestore.collection("products").snapshots();

  return collection.map((querySnapshot) {
    final products = querySnapshot.docs
        .map((doc) => ProductModel.fromSnapshot(doc))
        .toList();

    products.shuffle();

    return products.take(5).toList();
  });
});

final fetchAllProductProvider = StreamProvider<List<ProductModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final collection = firestore.collection("products").snapshots();

  return collection.map((querySnapshot) {
    final products = querySnapshot.docs
        .map((doc) => ProductModel.fromSnapshot(doc))
        .toList();

    products.shuffle();

    return products;
  });
});

final selectedProductsProvider =
    StreamProvider.family<List<FarmerProductModel>, String>((ref, filter) {
  final firestore = ref.watch(firestoreProvider);

  // Check if the filter is "all" or a specific category
  final collection = (filter.toLowerCase() == 'all')
      ? firestore.collection("shop_products").snapshots()
      : firestore
          .collection("shop_products")
          .where("category", isEqualTo: filter)
          .snapshots();

  return collection.map((querySnapshot) {
    final products = querySnapshot.docs
        .map((doc) => FarmerProductModel.fromSnapshot(doc))
        .toList();

    if (filter.toLowerCase() != 'all') {
      products.shuffle();
    }

    return products;
  });
});

final productSearchProvider = StreamProvider<List<ProductModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final collectionRef = firestore.collection('products');

  return collectionRef.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList());
});

final farmerProductSearchProvider =
    StreamProvider<List<FarmerProductModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final collectionRef = firestore.collection('shop_products');

  return collectionRef.snapshots().map((snapshot) => snapshot.docs
      .map((doc) => FarmerProductModel.fromSnapshot(doc))
      .toList());
});

final filteredProductsProvider =
    Provider.family<List<ProductModel>, String>((ref, query) {
  final products = ref.watch(productSearchProvider);

  if (query.isEmpty) {
    return products.value ?? [];
  }

  final filteredProducts = products.value
      ?.where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return filteredProducts ?? [];
});

final filteredFarmerProductsProvider =
    Provider.family<List<FarmerProductModel>, String>((ref, query) {
  final products = ref.watch(farmerProductSearchProvider);

  if (query.isEmpty) {
    return products.value ?? [];
  }

  final filteredProducts = products.value
      ?.where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return filteredProducts ?? [];
});

final productCountProvider = StreamProvider<int>((ref) {
  return FirebaseFirestore.instance.collection('products').snapshots().map(
        (snapshot) => snapshot.docs.length,
      );
});
