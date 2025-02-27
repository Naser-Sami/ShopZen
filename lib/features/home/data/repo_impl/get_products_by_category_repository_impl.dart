import '/features/_features.dart';

class GetProductsByCategoryRepositoryImpl implements IGetProductsByCategoryRepository {
  final IProductsRemoteDataSource remoteDataSource;
  GetProductsByCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProductCategoryList(String category) async {
    try {
      final response = await remoteDataSource.getProductsByCategory(category);
      // convert to entity
      final products = ProductsMapper.mapToEntity(response?.products ?? []);
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
