import '/core/_core.dart';
import '/features/_features.dart';

abstract class ISearchProductRemoteDataSource {
  Future<ProductsModel?> searchProduct(String query);
}

class SearchProductRemoteDataSourceImpl implements ISearchProductRemoteDataSource {
  final DioHelper dioHelper = DioHelper();

  @override
  Future<ProductsModel?> searchProduct(String query) async {
    try {
      final data = await dioHelper.get<ProductsModel>(
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
