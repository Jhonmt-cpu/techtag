import 'package:flutter/material.dart';
import 'package:techtag/app/utils/determine_card_flag.dart';
import 'package:techtag/app/values/app_colors.dart';

class CreditCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expirationDate;

  const CreditCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expirationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardType = determineCardFlag(cardNumber);
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: getCardColor(cardType),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              getCardImage(cardType),
              height: 30,
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                const Dot(),
                const Dot(),
                const Dot(),
                const Dot(),
                const Expanded(child: SizedBox()),
                const Dot(),
                const Dot(),
                const Dot(),
                const Dot(),
                const Expanded(child: SizedBox()),
                const Dot(),
                const Dot(),
                const Dot(),
                const Dot(),
                const Expanded(child: SizedBox()),
                Text(
                  cardNumber.substring(12),
                  style: const TextStyle(
                    color: AppColors.shape01,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nome no Cartão",
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.shape01.withOpacity(0.5),
                  ),
                ),
                Text(
                  "Data Ex.",
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.shape01.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardHolder,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.shape01,
                  ),
                ),
                Text(
                  expirationDate,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.shape01,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: AppColors.shape01.withOpacity(0.5),
        ),
      ),
    );
  }
}
