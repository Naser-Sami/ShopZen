import '/features/home/_home.dart';

class ProductRepositoryImpl implements IProductRepository {
  final IProductsRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final response = await remoteDataSource.getAllProducts();

      // convert to entity
      final products = ProductsMapper.mapToEntity(response?.products ?? []);

      return products;
    } catch (e) {
      rethrow;
    }
  }
}
