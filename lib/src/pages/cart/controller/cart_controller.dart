import 'package:get/get.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocery/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocery/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsServices();
  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0.00;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilServices.showToast(message: message);
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.id == item.id);
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      //já existe
      cartItems[itemIndex].quantity += quantity;
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        success: (cartItemId) {
          //não existe
          cartItems.add(CartItemModel(
            id: cartItemId,
            item: item,
            quantity: quantity,
          ));
        },
        error: (message) {
          utilServices.showToast(message: message, isError: true);
        },
      );
    }
  }
}
