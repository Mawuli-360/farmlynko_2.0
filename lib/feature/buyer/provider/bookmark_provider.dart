import 'package:farmlynko/feature/buyer/model/newsfeed_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Bookmark extends StateNotifier<List<NewsFeedModel>> {
  Bookmark() : super([]);

  void toggleBookmark(NewsFeedModel product) {
    final index = state.indexWhere((item) => item.id == product.id);
    if (index == -1) {
      state = [...state, product.copyWith(isBookmarked: true)];
    } else {
      state = [
        ...state.sublist(0, index),
        ...state.sublist(index + 1),
      ];
    }
  }

  void removeFromBookmark(NewsFeedModel product) {
    state = state.where((p) => p != product).toList();
  }
}

final bookmarkProvider =
    StateNotifierProvider<Bookmark, List<NewsFeedModel>>((ref) => Bookmark());
