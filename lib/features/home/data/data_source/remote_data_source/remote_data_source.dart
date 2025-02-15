import 'dart:developer';

import '/core/_core.dart';
import '/features/home/_home.dart';

abstract class IProductsRemoteDataSource {
  Future<ProductsModel?> getAllProducts();
  Future<ProductsModel> getProductById(int id);
}

class ProductsRemoteDataSourceImpl implements IProductsRemoteDataSource {
  final DioHelper dioHelper = DioHelper();

  @override
  Future<ProductsModel?> getAllProducts(
      {int limit = 0, int skip = 0, String? select}) async {
    try {
      final data = await dioHelper.get<ProductsModel>(
        path: ApiEndpoints.products,
        parser: (data) => ProductsModel.fromJson(data),
        queryParameters: {'limit': limit, 'skip': skip, 'select': select},
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductsModel> getProductById(int id) async {
    try {
      return await dioHelper.get(
        path: '${ApiEndpoints.products}/$id',
      );
    } catch (e) {
      rethrow;
    }
  }
}
