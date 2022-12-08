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

  int getCartTotalItems() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  Future<bool> changeItemQuantity(
      {required CartItemModel item, required int quantity}) async {
    final result = await cartRepository.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );
    print("Este é o item recebido para inclusão no carrinho  ");
    print('Adicionou produto ${item.id}');

    if (result) {
      if (quantity == 0) {
        print('NÃO FOI NO FIRST WHERE');
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        print('VEIO NO FIRST WHERE');
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }

      update();
    } else {
      utilServices.showToast(
        message: 'Erro ao alterar quantidade',
        isError: true,
      );
    }

    return result;
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
    print('CONFERINDO O WHERE $cartItems');
    int achei =
        cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
    print('Este é o achei $achei');
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      print('ITEM JÁ EXISTE ${item.id}');

      final product = cartItems[itemIndex];
      await changeItemQuantity(item: product, quantity: quantity);
      //já existe
    } else {
      print('NÃO EXISTE O ITEM NA LISTA ${item.id}');
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
    update();
  }
}
