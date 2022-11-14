// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:techtag/app/values/boxes.dart';

part 'credit_card_model.g.dart';

@HiveType(typeId: ModelIds.creditCard)
class CreditCardModel {
  @HiveField(0)
  String cardNumber;
  @HiveField(1)
  String cardHolder;
  @HiveField(2)
  String expireDate;
  @HiveField(3)
  String cvv;

  CreditCardModel({
    required this.cardNumber,
    required this.cardHolder,
    required this.expireDate,
    required this.cvv,
  });
}
