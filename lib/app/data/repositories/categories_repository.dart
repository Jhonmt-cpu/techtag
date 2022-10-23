import 'package:techtag/app/data/model/category_model.dart';
import 'package:techtag/app/data/provider/api.dart';

class CategoriesRepository {
  final api = Api();

  static final CategoriesRepository _categoriesRepository = CategoriesRepository._internal();
  CategoriesRepository._internal();

  factory CategoriesRepository() {
    return _categoriesRepository;
  }

  Future<List<CategoryModel>> getCategories() async {
    var response = await api.getCategories();

    var categoriesList = response.map((e) => CategoryModel.fromMap(e)).toList();

    return categoriesList;
  }
}
