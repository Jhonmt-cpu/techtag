import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:techtag/app/data/model/product_model.dart';
import 'package:techtag/app/values/boxes.dart';

class CartController extends GetxController {
  Box<ProductModel> cart = Hive.box<ProductModel>(Boxes.cartBox);

  final products = <ProductModel>[].obs;
  final total = 0.0.obs;

  @override
  void onInit() {
    ever(products, (value) => calcTotal());
    products.addAll(cart.values.cast<ProductModel>().toList());
    super.onInit();
  }

  void calcTotal() {
    double total = 0;

    for (var element in products) {
      total += (element.cartQuantity * element.value);
    }

    this.total.value = total;
  }

  Future<void> addProductQuantity(int index) async {
    await cart.clear();

    products[index].cartQuantity++;

    await cart.addAll(products);

    products.refresh();
  }

  Future<void> removeProductQuantity(int index) async {
    await cart.clear();

    products[index].cartQuantity--;

    if (products[index].cartQuantity <= 0) {
      products.removeAt(index);
    }

    if (products.isNotEmpty) {
      await cart.addAll(products);
    }

    products.refresh();
  }
}
