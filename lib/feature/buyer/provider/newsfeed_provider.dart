import 'package:farmlynko/feature/buyer/model/newsfeed_model.dart';
import 'package:farmlynko/feature/buyer/provider/firebase_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchNewsDetailProvider = StreamProvider<List<NewsFeedModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final collection = firestore.collection("newsfeed").snapshots();

  return collection.map((querySnapshot) {
    final news = querySnapshot.docs
        .map((doc) => NewsFeedModel.fromSnapshot(doc))
        .toList();

    return news;
  });
});
