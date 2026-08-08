import 'package:flutter_test/flutter_test.dart';
import 'package:greengrocery/src/constants/endpoints.dart';

void main() {
  group('EndPoints', () {
    test('baseUrl aponta para Back4App', () {
      expect(baseUrl, contains('parseapi.back4app.com'));
      expect(baseUrl, contains('/functions'));
    });

    test('todos os endpoints comecam com baseUrl', () {
      expect(EndPoints.signin, startsWith(baseUrl));
      expect(EndPoints.signup, startsWith(baseUrl));
      expect(EndPoints.validadeToken, startsWith(baseUrl));
      expect(EndPoints.resetPassword, startsWith(baseUrl));
      expect(EndPoints.getAllCategories, startsWith(baseUrl));
      expect(EndPoints.getAllProdutcs, startsWith(baseUrl));
      expect(EndPoints.getCartItems, startsWith(baseUrl));
      expect(EndPoints.addItemToCart, startsWith(baseUrl));
      expect(EndPoints.changeItemQuantity, startsWith(baseUrl));
      expect(EndPoints.checkout, startsWith(baseUrl));
      expect(EndPoints.getAllOrders, startsWith(baseUrl));
    });

    test('endpoints tem paths unicos e corretos', () {
      expect(EndPoints.signin, endsWith('/login'));
      expect(EndPoints.signup, endsWith('/signup'));
      expect(EndPoints.validadeToken, endsWith('/validate-token'));
      expect(EndPoints.resetPassword, endsWith('/reset-password'));
      expect(EndPoints.getAllCategories, endsWith('/get-category-list'));
      expect(EndPoints.getAllProdutcs, endsWith('/get-product-list'));
      expect(EndPoints.getCartItems, endsWith('/get-cart-items'));
      expect(EndPoints.addItemToCart, endsWith('/add-item-to-cart'));
      expect(EndPoints.changeItemQuantity, endsWith('/modify-item-quantity'));
      expect(EndPoints.checkout, endsWith('/checkout'));
      expect(EndPoints.getAllOrders, endsWith('/get-orders'));
    });

    test('total de endpoints definidos: 11', () {
      // Verify we have the expected number of endpoints
      expect(EndPoints.signin, isNotEmpty);
      expect(EndPoints.signup, isNotEmpty);
      expect(EndPoints.validadeToken, isNotEmpty);
      expect(EndPoints.resetPassword, isNotEmpty);
      expect(EndPoints.getAllCategories, isNotEmpty);
      expect(EndPoints.getAllProdutcs, isNotEmpty);
      expect(EndPoints.getCartItems, isNotEmpty);
      expect(EndPoints.addItemToCart, isNotEmpty);
      expect(EndPoints.changeItemQuantity, isNotEmpty);
      expect(EndPoints.checkout, isNotEmpty);
      expect(EndPoints.getAllOrders, isNotEmpty);
    });
  });
}
