import '/features/_features.dart';

class SearchProductRepositoryImpl extends ISearchProductRepository {
  final ISearchProductRemoteDataSource remoteDataSource;

  SearchProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> searchProduct(String query) async {
    try {
      final response = await remoteDataSource.searchProduct(query);

      // convert to entity
      final products = ProductsMapper.mapToEntity(response?.products ?? []);
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
