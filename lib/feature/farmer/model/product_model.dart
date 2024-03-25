// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String category;
  final String description;
  final String id;
  final String image;
  final String name;
  final String price;
  final String userId;
  ProductModel({
    required this.category,
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.userId,
  });

  ProductModel copyWith({
    String? category,
    String? description,
    String? id,
    String? image,
    String? name,
    String? price,
    String? userId,
  }) {
    return ProductModel(
      category: category ?? this.category,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'description': description,
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'userId': userId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      category: map['category'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      userId: map['userId'] as String,
    );
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(category: $category, description: $description, id: $id, image: $image, name: $name, price: $price, userId: $userId)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.description == description &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.price == price &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        description.hashCode ^
        id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        price.hashCode ^
        userId.hashCode;
  }
}
