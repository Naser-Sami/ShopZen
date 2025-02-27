import '/features/_features.dart';

abstract class IGetProductsByCategoryRepository {
  Future<List<ProductEntity>> getProductCategoryList(String category);
}
