// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CropCareModel {
  final String content;
  final String description;
  final String id;
  final String image;
  final String title;
  CropCareModel({
    required this.content,
    required this.description,
    required this.id,
    required this.image,
    required this.title,
  });

  CropCareModel copyWith({
    String? content,
    String? description,
    String? id,
    String? image,
    String? title,
  }) {
    return CropCareModel(
      content: content ?? this.content,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'description': description,
      'id': id,
      'image': image,
      'title': title,
    };
  }

  factory CropCareModel.fromMap(Map<String, dynamic> map) {
    return CropCareModel(
      content: map['content'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  factory CropCareModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

    return CropCareModel(
      content: map['content'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CropCareModel.fromJson(String source) =>
      CropCareModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CropCareModel(content: $content, description: $description, id: $id, image: $image, title: $title)';
  }

  @override
  bool operator ==(covariant CropCareModel other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.description == description &&
        other.id == id &&
        other.image == image &&
        other.title == title;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        description.hashCode ^
        id.hashCode ^
        image.hashCode ^
        title.hashCode;
  }
}
