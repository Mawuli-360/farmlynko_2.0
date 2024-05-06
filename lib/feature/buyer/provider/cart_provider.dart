import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlynko/feature/farmer/model/farmer_product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedAddOnsProvider =
    StateNotifierProvider<SelectedAddOnsNotifier, List<FarmerProductModel>>((ref) {
  return SelectedAddOnsNotifier();
});

class SelectedAddOnsNotifier extends StateNotifier<List<FarmerProductModel>> {
  SelectedAddOnsNotifier() : super([]);

  void toggleAddOn(FarmerProductModel addOn) {
    state = state.contains(addOn)
        ? state.where((item) => item != addOn).toList()
        : [...state, addOn];
  }

  void clearSelectedAddOns() {
    state = [];
  }
}

final randomAddOnsProvider =
    StreamProvider.autoDispose<List<FarmerProductModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('shop_products').snapshots();

  return collection.map((querySnapshot) {
    final randomIndices =
        List.generate(3, (index) => Random().nextInt(querySnapshot.size));
    final randomAddOns = <FarmerProductModel>[];

    for (int index in randomIndices) {
      final FarmerProductModel addOn =
          FarmerProductModel.fromSnapshot(querySnapshot.docs[index]);
      randomAddOns.add(addOn);
    }

    return randomAddOns;
  });
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(FarmerProductModel mainProduct, List<FarmerProductModel> selectedAddOns) {
    final cartItems = [mainProduct, ...selectedAddOns];

    for (var item in cartItems) {
      final index = state.indexWhere((cartItem) => cartItem.product == item);
      if (index >= 0) {
        state[index].quantity += 1;
      } else {
        state = [...state, CartItem(item, 1)];
      }
    }
  }

  void removeFromCart(FarmerProductModel product) {
    state = state.where((cartItem) => cartItem.product != product).toList();
  }

  void updateCartItemQuantity(FarmerProductModel product, int newQuantity) {
    final index =
        state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state[index].quantity = newQuantity;
      state = [...state]; // Notify listeners of the state change
    }
  }

  void clearCartAndSelectedAddOns(
      SelectedAddOnsNotifier selectedAddOnsNotifier) {
    state = []; // Clear the cart
    selectedAddOnsNotifier.clearSelectedAddOns(); // Clear the selected add-ons
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartItem {
  final FarmerProductModel product;
  int quantity;

  CartItem(this.product, this.quantity);
}
