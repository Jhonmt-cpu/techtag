import 'package:get/get.dart';
import 'package:techtag/app/data/model/category_model.dart';
import 'package:techtag/app/data/model/product_model.dart';
import 'package:techtag/app/data/repositories/categories_repository.dart';
import 'package:techtag/app/data/repositories/products_repository.dart';

class HomeController extends GetxController {
  final _categoriesRepository = CategoriesRepository();
  final _productsRepository = ProductsRepository();

  final categoriesList = <CategoryModel>[].obs;
  final productsList = <ProductModel>[].obs;

  @override
  void onInit() {
    getCategoriesAndOffers();
    super.onInit();
  }

  Future<void> getCategoriesAndOffers() async {
    var futures = [
      _categoriesRepository.getCategories(),
      _productsRepository.getProducts(),
    ];

    var results = await Future.wait(futures);

    categoriesList.addAll(results.first as List<CategoryModel>);
    productsList.addAll(results.last as List<ProductModel>);
  }
}
