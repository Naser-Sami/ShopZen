import '/core/_core.dart';
import '/features/_features.dart';

abstract class ISearchProductRemoteDataSource {
  Future<ProductsModel> searchProduct(String query);
}

class SearchProductRemoteDataSourceImpl implements ISearchProductRemoteDataSource {
  final DioHelper dioHelper = DioHelper();

  @override
  Future<ProductsModel> searchProduct(String query) async {
    try {
      return await dioHelper.get(
        path: ApiEndpoints.search,
        queryParameters: {'q': query},
      );
    } catch (e) {
      rethrow;
    }
  }
}
