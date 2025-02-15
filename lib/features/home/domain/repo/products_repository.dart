import '/features/home/_home.dart';

abstract class IProductRepository {
  Future<List<ProductEntity>> getAllProducts();
}
