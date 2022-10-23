import 'package:techtag/app/data/model/product_model.dart';
import 'package:techtag/app/data/provider/api.dart';

class ProductsRepository {
  final api = Api();

  static final ProductsRepository _productsRepository = ProductsRepository._internal();
  ProductsRepository._internal();

  factory ProductsRepository() {
    return _productsRepository;
  }

  Future<List<ProductModel>> getProducts() async {
    var response = await api.getProducts();

    var products = response.map((e) => ProductModel.fromMap(e)).toList();

    return products;
  }
}
