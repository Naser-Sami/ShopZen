import '/features/_features.dart';

abstract class ICategoriesRepository {
  Future<List<CategoriesEntity>> getCategories();
}
