import '/features/home/_home.dart';

class ProductRepositoryImpl implements IProductRepository {
  final IProductsRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  int _totalProducts = 0;

  @override
  Future<List<ProductEntity>> getAllProducts(
      {required int limit, int skip = 0, String? select}) async {
    try {
      final response =
          await remoteDataSource.getAllProducts(limit: limit, skip: skip, select: select);

      totalProducts = (response?.total ?? 0) as int;

      // convert to entity
      final products = ProductsMapper.mapToEntity(response?.products ?? []);

      return products;
    } catch (e) {
      rethrow;
    }
  }

  @override
  set totalProducts(int value) {
    _totalProducts = value;
  }

  @override
  int get totalProducts => _totalProducts;
}
