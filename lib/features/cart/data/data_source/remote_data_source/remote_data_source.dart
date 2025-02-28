import '/core/_core.dart';

import '/features/cart/_cart.dart';

abstract class ICartRemoteDataSource {
  Future<CartModel?> getCartItems(String id);
}

class CartRemoteDataSource extends ICartRemoteDataSource {
  final DioHelper dioHelper = DioHelper();

  @override
  Future<CartModel?> getCartItems(String id) async {
    try {
      return await dioHelper.get<CartModel>(
        path: "${ApiEndpoints.cart}/$id",
        parser: (data) => CartModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}
