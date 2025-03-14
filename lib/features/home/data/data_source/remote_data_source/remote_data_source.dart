import 'dart:developer';

import '/core/_core.dart';
import '/features/home/_home.dart';

abstract class IProductsRemoteDataSource {
  Future<ProductsModel?> getAllProducts({required int limit, int skip, String? select});
  Future<ProductsModel?> getProductById(int id);
  Future<List<String>?> getProductCategoryList();
  Future<ProductsModel?> getProductsByCategory(String category);
}

class ProductsRemoteDataSourceImpl implements IProductsRemoteDataSource {
  final DioService dioService = DioService();

  @override
  Future<ProductsModel?> getAllProducts(
      {required int limit, int skip = 0, String? select}) async {
    try {
      final data = await dioService.get<ProductsModel>(
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
  Future<ProductsModel?> getProductById(int id) async {
    try {
      return await dioService.get<ProductsModel>(
        path: '${ApiEndpoints.products}/$id',
        parser: (data) => ProductsModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> getProductCategoryList() async {
    try {
      final response = await dioService.get<List<dynamic>>(
        path: '${ApiEndpoints.products}/${ApiEndpoints.categoryList}',
        parser: (data) => data.map((item) => "$item").toList(),
      );

      return response?.cast<String>();
    } catch (e) {
      log('Error fetching categories: $e');
      rethrow;
    }
  }

  @override
  Future<ProductsModel?> getProductsByCategory(String category) async {
    try {
      return await dioService.get<ProductsModel>(
        path: '${ApiEndpoints.products}/${ApiEndpoints.category}/$category',
        parser: (data) => ProductsModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
