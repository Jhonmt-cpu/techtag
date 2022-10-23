// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CategoryModel {
  String id;
  Uint8List icon;
  String name;

  CategoryModel({
    required this.id,
    required this.icon,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'iconUrl': icon,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    var iconData = (map['icon'] as String).split(',');
    var icon = base64Decode(iconData.last);

    return CategoryModel(
      id: map['id'] as String,
      icon: icon,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
