import '/features/home/_home.dart';

abstract class IProductRepository {
  set totalProducts(int value);
  int get totalProducts;
  Future<List<ProductEntity>> getAllProducts({int limit, int skip, String? select});
}
