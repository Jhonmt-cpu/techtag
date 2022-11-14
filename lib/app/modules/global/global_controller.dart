import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:techtag/app/data/model/product_model.dart';
import 'package:techtag/app/values/boxes.dart';

class GlobalController extends GetxController {
  Box<ProductModel>? cart;

  final products = <ProductModel>[].obs;

  @override
  void onInit() async {
    cart = await Hive.openBox<ProductModel>(Boxes.cartBox);
    super.onInit();
  }

  void getProductsFromCache() {
    products.addAll(cart!.values.cast<ProductModel>().toList());
  }

  Future<void> addProduct(ProductModel product) async {
    await cart!.clear();

    products.add(product);

    await cart!.addAll(products);

    products.refresh();
  }

  Future<void> removeProduct(ProductModel product) async {
    await cart!.clear();

    products.remove(product);

    if (products.isNotEmpty) {
      await cart!.addAll(products);
    }

    products.refresh();
  }
}
