// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String description;
  final String imageUrl;
  final String name;
  final String price;
  final String productId;
  final String productOwner;
  final String profilePic;
  final String userId;
  final String userPhoneNumber;
  ProductModel({
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.productId,
    required this.productOwner,
    required this.profilePic,
    required this.userId,
    required this.userPhoneNumber,
  });

  ProductModel copyWith({
    String? description,
    String? imageUrl,
    String? name,
    String? price,
    String? productId,
    String? productOwner,
    String? profilePic,
    String? userId,
    String? userPhoneNumber,
  }) {
    return ProductModel(
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      productOwner: productOwner ?? this.productOwner,
      profilePic: profilePic ?? this.profilePic,
      userId: userId ?? this.userId,
      userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'productId': productId,
      'productOwner': productOwner,
      'profilePic': profilePic,
      'userId': userId,
      'userPhoneNumber': userPhoneNumber,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

    return ProductModel(
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      productId: map['productId'] as String,
      productOwner: map['productOwner'] as String,
      profilePic: map['profilePic'] as String,
      userId: map['userId'] as String,
      userPhoneNumber: map['userPhoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ProductModel(description: $description, imageUrl: $imageUrl, name: $name, price: $price, productId: $productId, productOwner: $productOwner, profilePic: $profilePic, userId: $userId, userPhoneNumber: $userPhoneNumber)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.imageUrl == imageUrl &&
        other.name == name &&
        other.price == price &&
        other.productId == productId &&
        other.productOwner == productOwner &&
        other.profilePic == profilePic &&
        other.userId == userId &&
        other.userPhoneNumber == userPhoneNumber;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        imageUrl.hashCode ^
        name.hashCode ^
        price.hashCode ^
        productId.hashCode ^
        productOwner.hashCode ^
        profilePic.hashCode ^
        userId.hashCode ^
        userPhoneNumber.hashCode;
  }
}
