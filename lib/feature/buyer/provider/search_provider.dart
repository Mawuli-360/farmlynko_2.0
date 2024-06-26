import 'package:farmlynko/feature/buyer/model/product_model.dart';
import 'package:farmlynko/feature/buyer/provider/firebase_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');


final filteredProductsProvider =
    Provider.family<List<ProductModel>, String>((ref, query) {
  final products = ref.watch(productSearchProvider);

  if (query.isEmpty) {
    return products.value ?? [];
  }

  final filteredProducts = products.value
      ?.where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return filteredProducts ?? [];
});

final productSearchProvider = StreamProvider<List<ProductModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final collectionRef = firestore.collection('products');

  return collectionRef.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList());
});