import '/core/_core.dart';
import '/features/_features.dart';

abstract class ISearchProductRemoteDataSource {
  Future<ProductsModel?> searchProduct(String query);
}

class SearchProductRemoteDataSourceImpl implements ISearchProductRemoteDataSource {
  final DioService dioService = DioService();

  @override
  Future<ProductsModel?> searchProduct(String query) async {
    try {
      final data = await dioService.get<ProductsModel>(
        path: ApiEndpoints.search,
        parser: (data) => ProductsModel.fromJson(data),
        queryParameters: {'q': query},
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
