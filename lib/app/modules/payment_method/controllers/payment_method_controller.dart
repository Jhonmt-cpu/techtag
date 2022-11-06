import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:techtag/app/components/button.dart';
import 'package:techtag/app/components/complex_text_input.dart';
import 'package:techtag/app/components/message_dialog.dart';
import 'package:techtag/app/data/model/credit_card_model.dart';
import 'package:techtag/app/data/model/product_model.dart';
import 'package:techtag/app/data/repositories/orders_repository.dart';
import 'package:techtag/app/routes/app_pages.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';
import 'package:techtag/app/values/boxes.dart';

class PaymentMethodController extends GetxController {
  final _ordersRepository = OrdersRepository();

  final pageController = PageController(viewportFraction: 0.85);
  final currentPosition = (-1).obs;

  Box<CreditCardModel> creditCardBox = Hive.box<CreditCardModel>(Boxes.creditCardBox);
  Box<ProductModel> cart = Hive.box<ProductModel>(Boxes.cartBox);

  final creditCards = <CreditCardModel>[].obs;
  final products = <ProductModel>[].obs;

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expireDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final RxString cardNumberError = "".obs;
  final RxString cardHolderError = "".obs;
  final RxString expireDateError = "".obs;
  final RxString cvvError = "".obs;

  final RxBool isLoading = false.obs;

  String cardNumber = "";

  RxDouble total = 0.0.obs;

  @override
  void onInit() {
    pageController.addListener(() {
      currentPosition.value = pageController.page?.round() ?? 0;
    });
    products.addAll(cart.values.cast<ProductModel>().toList());
    getCreditCards();
    calcTotal();
    super.onInit();
  }

  void calcTotal() {
    double total = 0;

    for (var element in products) {
      total += (element.cartQuantity * element.value);
    }

    this.total.value = total;
  }

  Future<void> requestOrder() async {
    try {
      isLoading.value = true;

      var orderId = await _ordersRepository.requestOrder(
        products: products,
        creditCard: creditCards[currentPosition.value],
      );

      await cart.clear();

      Get.offNamedUntil(Routes.ORDER_DETAILS, ModalRoute.withName(Routes.HOME), arguments: orderId);
    } catch (e) {
      Get.dialog(const MessageDialog(
        message: "Não foi possível realizar o pedido",
      ));
    } finally {
      isLoading.value = false;
    }
  }

  void getCreditCards() {
    creditCards.clear();
    creditCards.addAll(creditCardBox.values.cast<CreditCardModel>().toList());
    if (creditCards.isNotEmpty) {
      currentPosition.value = 0;
    }
  }

  void addCreditCard() {
    cardHolderError.value = cardNumberError.value = expireDateError.value = cvvError.value = "";

    checkName(cardHolderController.text);
    checkCardNumber(cardNumber);
    checkExpireDate(expireDateController.text);
    checkCvv(cvvController.text);

    if (cardHolderError.value.isEmpty &&
        cardNumberError.value.isEmpty &&
        expireDateError.value.isEmpty &&
        cvvError.value.isEmpty) {
      var creditCard = CreditCardModel(
        cardNumber: cardNumber,
        cardHolder: cardHolderController.text,
        expireDate: expireDateController.text,
        cvv: cvvController.text,
      );

      creditCardBox.add(creditCard);

      cardHolderController.text = cardNumberController.text =
          expireDateController.text = cvvController.text = cardNumber = "";

      getCreditCards();
      Get.back();
    }
  }

  void checkName(String? text) {
    if (text != null) {
      if (!RegExp(AppStrings.reName).hasMatch(text)) {
        cardHolderError.value = AppStrings.errorName;
      } else {
        cardHolderError.value = '';
      }
    } else {
      cardHolderError.value = AppStrings.errorName;
    }
  }

  void checkCardNumber(String? text) {
    if (text != null) {
      String cardNumbers = text.replaceAll(RegExp(AppStrings.reNotNumber), '');
      if (cardNumbers.length != 16) {
        cardNumberError.value = AppStrings.errorCardNumber;
      } else {
        cardNumberError.value = '';

        cardNumber = cardNumbers;
      }
    } else {
      cardNumberError.value = AppStrings.errorCardNumber;
    }
  }

  void checkExpireDate(String? text) {
    DateTime parsedDate;

    if (text != null) {
      if (!RegExp(AppStrings.reExpirationDate).hasMatch(text)) {
        expireDateError.value = AppStrings.errorDate;
      } else {
        var dateSplitted = text.split('/');
        parsedDate = DateTime.parse('20${dateSplitted[1]}-${dateSplitted[0]}-01');
        DateTime now = DateTime.now();

        if (parsedDate.isBefore(now)) {
          expireDateError.value = AppStrings.errorDate;
        } else {
          expireDateError.value = '';
        }
      }
    } else {
      expireDateError.value = AppStrings.errorBirthday;
    }
  }

  void checkCvv(String? text) {
    if (text != null) {
      String cvvCode = text.replaceAll(RegExp(AppStrings.reNotNumber), '');
      if (cvvCode.length != 3) {
        cvvError.value = AppStrings.errorCvv;
      } else {
        cvvError.value = '';
      }
    } else {
      cvvError.value = AppStrings.errorCvv;
    }
  }

  Future<void> openAddNewCardBottomSheet(BuildContext context) async {
    await showSlidingBottomSheet(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 30,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [1],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/close.svg",
                        height: 12,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Adicionar novo cartão",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.base,
                        ),
                      ),
                    ),
                    Obx(
                      () => ComplexTextInput(
                        labelText: "Nome no cartão",
                        roundBordersTop: true,
                        errorText: cardHolderError.value,
                        textEditingController: cardHolderController,
                        inputFormatters: [
                          FilteringTextInputFormatter(
                            RegExp(r"[A-Za-zÀ-ÖØ-öø-ÿ0-9'\s]"),
                            allow: true,
                          ),
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        textInputAction: TextInputAction.next,
                        onChanged: (text) => checkName(text),
                      ),
                    ),
                    Obx(
                      () => ComplexTextInput(
                        labelText: "Número do cartão",
                        errorText: cardNumberError.value,
                        textEditingController: cardNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CardNumberFormatter(),
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        textInputAction: TextInputAction.next,
                        onChanged: (text) => checkCardNumber(text),
                      ),
                    ),
                    SizedBox(
                      width: Get.width - (2 * 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Obx(
                              () => ComplexTextInput(
                                labelText: "Data de Ex.",
                                roundBorderBottomLeft: true,
                                errorText: expireDateError.value,
                                textEditingController: expireDateController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  MonthYearDateFormatter(),
                                  FilteringTextInputFormatter.singleLineFormatter,
                                ],
                                onChanged: (text) => checkExpireDate(text),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Obx(
                              () => ComplexTextInput(
                                labelText: "CVV",
                                roundBorderBottomRight: true,
                                obscureText: true,
                                maxLength: 3,
                                textEditingController: cvvController,
                                errorText: cvvError.value,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.singleLineFormatter,
                                ],
                                onChanged: (text) => checkCvv(text),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          // ComplexTextInput(labelText: "CVV"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Button(
                      enable: true,
                      text: "Adicionar Cartão",
                      onTap: () => addCreditCard(),
                      backgroundColor: AppColors.purple,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
