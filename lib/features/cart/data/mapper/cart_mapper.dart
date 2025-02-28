import '/features/cart/_cart.dart';

class CartMapper {
  static CartEntity mapToEntity(CartModel model) {
    return CartEntity.fromModel(model);
  }

  static CartModel mapToModel(CartEntity entity) {
    return entity.toModel();
  }
}
