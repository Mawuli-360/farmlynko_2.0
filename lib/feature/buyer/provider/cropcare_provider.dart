
import 'package:farmlynko/feature/buyer/model/cropcare_model.dart';
import 'package:farmlynko/feature/buyer/provider/firebase_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchCropDetailProvider = StreamProvider<List<CropCareModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final collection = firestore.collection("cropcare").snapshots();

  return collection.map((querySnapshot) {
    final crops = querySnapshot.docs
        .map((doc) => CropCareModel.fromSnapshot(doc))
        .toList();

    return crops;
  });
});
