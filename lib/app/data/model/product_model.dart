// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:techtag/app/values/boxes.dart';

part 'product_model.g.dart';

@HiveType(typeId: ModelIds.kart)
class ProductModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  Uint8List image;
  @HiveField(2)
  String name;
  @HiveField(3)
  bool isAvailable;
  @HiveField(4)
  double value;
  @HiveField(5)
  int cartQuantity;
  @HiveField(6)
  int quantity;
  List<ProductCategory>? productCategories;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.isAvailable,
    required this.value,
    required this.cartQuantity,
    required this.quantity,
    this.productCategories,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image.toString(),
      'name': name,
      'isAvailable': isAvailable,
      'value': value,
      'productCategories': productCategories?.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, dynamic> toOrderProductMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'quantity': cartQuantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    var imageData = (map['image'] as String).split(',');
    var image = base64Decode(imageData.last);
    return ProductModel(
      id: map['id'] as String,
      image: image,
      name: map['name'] as String,
      isAvailable: map['isAvailable'] as bool,
      value: double.parse(map['value'] as String),
      cartQuantity: 0,
      quantity: map['quantity'] as int,
      productCategories: map['CategoriesOnProducts'] != null
          ? List<ProductCategory>.from(
              (map['CategoriesOnProducts'] as List<dynamic>).map<ProductCategory>(
                (x) => ProductCategory.fromMap(x['category'] as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductCategory {
  String id;
  String name;
  ProductCategory({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
