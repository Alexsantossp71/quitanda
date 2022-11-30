import 'package:get/get.dart';
import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getCartItems,
      method: HttpMethodos.post,
      headers: {'X-Parse-Session-Token': token},
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
      // print(result['result']);
    } else {
      return CartResult.error('Não conseguiu buscar os itens do carrinho.');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.addItemToCart,
        method: HttpMethodos.post,
        body: {
          'user': userId,
          'quantity': quantity,
          'productId': productId,
        },
        headers: {
          'X-Parse-Session-Token': token,
        });

    if (result['result'] != null) {
      //funcionou adicionou
      return CartResult.success(result['result']['id']);
    } else {
      //Errou
      return CartResult.error('Erro ao addicionar produtos.');
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.changeItemQuantity,
      method: HttpMethodos.post,
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    return result.isEmpty;
  }
}
