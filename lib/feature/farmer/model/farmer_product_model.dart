import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerProductModel {
  final String category;
  final String description;
  final String id;
  final String imageUrl;
  final String name;
  final int price;
  FarmerProductModel({
    required this.category,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  FarmerProductModel copyWith({
    String? category,
    String? description,
    String? id,
    String? imageUrl,
    String? name,
    int? price,
  }) {
    return FarmerProductModel(
      category: category ?? this.category,
      description: description ?? this.description,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'description': description,
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
    };
  }

  factory FarmerProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return FarmerProductModel(
      category: map['category'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'FarmerProductModel(category: $category, description: $description, id: $id, imageUrl: $imageUrl, name: $name, price: $price)';
  }

  @override
  bool operator ==(covariant FarmerProductModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.description == description &&
        other.id == id &&
        other.imageUrl == imageUrl &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        description.hashCode ^
        id.hashCode ^
        imageUrl.hashCode ^
        name.hashCode ^
        price.hashCode;
  }
}
