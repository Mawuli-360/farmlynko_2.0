// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class ProductModel {
  final String description;
  final String imageUrl;
  final String name;
  final String price;
  final String productId;
  final String userId;
  ProductModel({
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.productId,
    required this.userId,
  });



  ProductModel copyWith({
    String? description,
    String? imageUrl,
    String? name,
    String? price,
    String? productId,
    String? userId,
  }) {
    return ProductModel(
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'productId': productId,
      'userId': userId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      productId: map['productId'] as String,
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
    return 'ProductModel(description: $description, imageUrl: $imageUrl, name: $name, price: $price, productId: $productId, userId: $userId)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.description == description &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      other.price == price &&
      other.productId == productId &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return description.hashCode ^
      imageUrl.hashCode ^
      name.hashCode ^
      price.hashCode ^
      productId.hashCode ^
      userId.hashCode;
  }
}
