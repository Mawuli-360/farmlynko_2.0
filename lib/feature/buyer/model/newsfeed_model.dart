import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewsFeedModel {
  final String content;
  final String date;
  final String description;
  final String id;
  final String image;
  final String title;
  bool isBookmarked;
  NewsFeedModel(
      {required this.content,
      required this.date,
      required this.description,
      required this.id,
      required this.image,
      required this.title,
      this.isBookmarked = false});

  NewsFeedModel copyWith(
      {String? content,
      String? date,
      String? description,
      String? id,
      String? image,
      String? title,
      required bool isBookmarked}) {
    return NewsFeedModel(
      content: content ?? this.content,
      date: date ?? this.date,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'date': date,
      'description': description,
      'id': id,
      'image': image,
    };
  }

  factory NewsFeedModel.fromMap(Map<String, dynamic> map) {
    return NewsFeedModel(
      content: map['content'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  factory NewsFeedModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

    return NewsFeedModel(
      content: map['content'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsFeedModel.fromJson(String source) =>
      NewsFeedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsFeedModel(content: $content, date: $date, description: $description, id: $id, image: $image)';
  }

  @override
  bool operator ==(covariant NewsFeedModel other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.date == date &&
        other.description == description &&
        other.id == id &&
        other.image == image;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        date.hashCode ^
        description.hashCode ^
        id.hashCode ^
        image.hashCode;
  }
}
