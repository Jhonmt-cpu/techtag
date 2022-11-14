// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  String id;
  String paymentMethod;
  String status;
  DateTime createdAt;
  List<ProductOrder> products;

  OrderModel({
    required this.id,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': createdAt,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      paymentMethod: map['paymentMethod'] as String,
      status: map['status'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      products: List<ProductOrder>.from(
        (map['ProductOnOrder']).map<ProductOrder>(
          (x) => ProductOrder.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductOrder {
  String name;
  int quantity;
  String value;

  ProductOrder({
    required this.name,
    required this.quantity,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'quantity': quantity,
      'value': value,
    };
  }

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      name: map['product']['name'] as String,
      quantity: map['quantity'] as int,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductOrder.fromJson(String source) =>
      ProductOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}
