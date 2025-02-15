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
      {int limit = 30, int skip = 0, String? select}) async {
    try {
      // _TypeError (type '(dynamic) => ProductsModel' is not a subtype of type
      // '(String, dynamic) => MapEntry<dynamic, dynamic>' of 'transform')

      // [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception:
      // type '(dynamic) => ProductModel' is not a subtype of type
      // '(String, dynamic) => MapEntry<dynamic, dynamic>' of 'transform'

      final data = await dioHelper.get<ProductsModel>(
        path: ApiEndpoints.products,
        parser: (data) => ProductsModel.fromJson(data),
        queryParameters: {'limit': limit, 'skip': skip, 'select': select},
      );

      log("ProductsRemoteDataSourceImpl: $data");

      log("-----------------------------");

      // return List<ProductsModel>.from(
      //   data.map(
      //     (product) => ProductsModel.fromJson(product),
      //   ),
      // );

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
