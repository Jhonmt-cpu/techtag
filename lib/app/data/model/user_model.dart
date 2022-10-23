import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:techtag/app/values/boxes.dart';

part 'user_model.g.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
@HiveType(typeId: ModelIds.user)
class UserModel {
  @HiveField(0)
  String token;

  UserModel({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
