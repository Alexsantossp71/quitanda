import 'package:flutter_test/flutter_test.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/models/item_model.dart';

void main() {
  group('CartItemModel', () {
    late ItemModel item;
    late CartItemModel cartItem;

    setUp(() {
      item = ItemModel(
        id: 'p1',
        itemName: 'Uva Thompson',
        imgUrl: 'https://example.com/grape.png',
        price: 7.89,
        unit: 'kg',
        description: 'Uvas sem sementes.',
      );
      cartItem = CartItemModel(
        id: 'cart-1',
        item: item,
        quantity: 3,
      );
    });

    test('cria CartItemModel com dados corretos', () {
      expect(cartItem.id, 'cart-1');
      expect(cartItem.item, item);
      expect(cartItem.quantity, 3);
    });

    test('calcula preço total corretamente', () {
      expect(cartItem.totalPrice(), closeTo(23.67, 0.01));
    });

    test('calcula preço total com quantidade 1', () {
      final single = CartItemModel(id: 'c2', item: item, quantity: 1);
      expect(single.totalPrice(), closeTo(7.89, 0.01));
    });

    test('calcula preço total com quantidade zero', () {
      final zero = CartItemModel(id: 'c3', item: item, quantity: 0);
      expect(zero.totalPrice(), 0.0);
    });

    test('serializa para JSON com campos corretos', () {
      final json = cartItem.toJson();
      expect(json['id'], 'cart-1');
      expect(json['quantity'], 3);
      expect(json['product'], isNotNull);
    });

    test('toString contém dados relevantes', () {
      final str = cartItem.toString();
      expect(str.contains('cart-1'), true);
    });
  });
}
