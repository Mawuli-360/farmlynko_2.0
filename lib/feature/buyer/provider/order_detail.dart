import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderDetailsProvider = StateProvider<OrderDetails?>((ref) => null);

class OrderDetails {
  final int numberOfItems;
  final List<String> itemNames;
  final double totalAmount;

  OrderDetails({
    required this.numberOfItems,
    required this.itemNames,
    required this.totalAmount,
  });
}

final orderListProvider =
    StateNotifierProvider<OrderListNotifier, List<OrderDetails>>((ref) {
  return OrderListNotifier();
});

class OrderListNotifier extends StateNotifier<List<OrderDetails>> {
  OrderListNotifier() : super([]);

  void addOrder(OrderDetails order) {
    state = [...state, order];
  }
}
