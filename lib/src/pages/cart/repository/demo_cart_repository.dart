import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/models/order_model.dart';
import 'package:greengrocery/src/config/demo_data.dart';
import 'package:greengrocery/src/pages/cart/cart_result/cart_result.dart';

/// Provides mock cart operations for demo mode.
class DemoCartRepository {
  /// In demo mode, cart is empty by default.
  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return CartResult<List<CartItemModel>>.success([]);
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return CartResult<OrderModel>.success(demoOrders.first);
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<CartResult<String>> addItemToCart({
    required String token,
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return CartResult.success('demo-cart-item-${DateTime.now().millisecondsSinceEpoch}');
  }
}
