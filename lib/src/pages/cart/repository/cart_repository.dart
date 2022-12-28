import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/models/order_model.dart';
import 'package:greengrocery/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();
  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.getCartItems,
        method: HttpMethodos.post,
        headers: {
          'X-Parse-Session-Token': token,
        },
        body: {
          'user': userId,
        });

    if (result['result'] != null) {
//tratar
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      //erro retornar mensagem de erro
      return CartResult.error('Ocorreu erro ao acessar os itens do carrinho');
    }
  } ////FIM DO getCartItems

  /// INICIO CHECKOUT

  Future<CartResult<OrderModel>> checkoutCart(
      {required String token, required double total}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.checkout,
      method: HttpMethodos.post,
      body: {
        'total': total,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Erro ao finalizar pedido, tente outra vez!');
    }
  }

  /// FIM CHECKOUT

  /// inicio modifica quantidade
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

  /// FIM DO MODIFICA QUANTIDADE
  Future<CartResult<String>> addItemToCart(
      {required String token,
      required String userId,
      required String productId,
      required int quantity}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.addItemToCart,
      method: HttpMethodos.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
    );

    if (result['result'] != null) {
      // adicionamos o produto
      return CartResult.success(result['result']['id']);
    } else {
      //produto não foi adicionado - ERRO
      return CartResult.error('Não foi possivel adicionar item no carrinho');
    }
  }

  // FIM do addItemToCart
}
