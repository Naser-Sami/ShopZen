import '/features/cart/_cart.dart';

class CartRepositoryImpl implements ICartRepository {
  final ICartRemoteDataSource remoteDataSource;
  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<CartEntity?> getCartItems(String id) async {
    final response = await remoteDataSource.getCartItems(id);
    // Mapping the result to the model
    if (response != null) {
      final cart = CartMapper.mapToEntity(response);
      return cart;
    }

    return null;
  }
}
