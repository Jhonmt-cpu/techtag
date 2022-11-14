import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:techtag/app/values/app_colors.dart';

CreditCardType determineCardFlag(String cardNumber) {
  var cardType = detectCCType(cardNumber);

  return cardType;
}

Color getCardColor(CreditCardType cardType) {
  switch (cardType) {
    case CreditCardType.visa:
      return AppColors.visaCard;
    case CreditCardType.mastercard:
      return AppColors.masterCard;
    case CreditCardType.elo:
      return AppColors.eloCard;
    default:
      return AppColors.purple;
  }
}

String getCardImage(CreditCardType cardType) {
  switch (cardType) {
    case CreditCardType.visa:
      return "assets/images/visa.png";
    case CreditCardType.mastercard:
      return "assets/images/mastercard.png";
    case CreditCardType.elo:
      return "assets/images/elo.png";
    default:
      return "assets/images/creditCard.png";
  }
}
