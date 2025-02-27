import '/features/_features.dart';

class GetProductCategoryListRepositoryImpl implements IGetProductCategoryListRepository {
  final IProductsRemoteDataSource remoteDataSource;
  GetProductCategoryListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<String>> getProductCategoryList() async {
    try {
      return await remoteDataSource.getProductCategoryList() ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
