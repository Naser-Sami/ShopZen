import '/features/cart/_cart.dart';

abstract class ICartRepository {
  Future<CartEntity?> getCartItems(String id);
}
