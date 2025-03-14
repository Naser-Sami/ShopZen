import '/core/_core.dart';

import '/features/cart/_cart.dart';

abstract class ICartRemoteDataSource {
  Future<CartModel?> getCartItems(String id);
}

class CartRemoteDataSource extends ICartRemoteDataSource {
  final DioService dioService = DioService();

  @override
  Future<CartModel?> getCartItems(String id) async {
    try {
      return await dioService.get<CartModel>(
        path: "${ApiEndpoints.cart}/$id",
        parser: (data) => CartModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
