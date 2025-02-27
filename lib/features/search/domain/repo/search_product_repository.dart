import '/features/_features.dart';

abstract class ISearchProductRepository {
  Future<List<ProductEntity>> searchProduct(String query);
}
