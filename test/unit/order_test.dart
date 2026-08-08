import 'package:flutter_test/flutter_test.dart';
import 'package:greengrocery/src/models/order_model.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/models/item_model.dart';

void main() {
  group('OrderModel', () {
    late ItemModel item;
    late CartItemModel cartItem;
    late OrderModel order;

    setUp(() {
      item = ItemModel(
        id: 'p1',
        itemName: 'Maçã',
        imgUrl: 'https://example.com/apple.png',
        price: 5.50,
        unit: 'kg',
        description: 'Maçã fresca.',
      );
      cartItem = CartItemModel(id: 'ci-1', item: item, quantity: 2);
      order = OrderModel(
        id: 'order-123',
        createdDateTime: DateTime(2026, 1, 15, 10, 0),
        overdueDateTime: DateTime(2026, 1, 15, 11, 0),
        items: [cartItem],
        status: 'delivered',
        copyAndPaste: 'PIX123abc',
        total: 11.0,
        qrCodeImage: 'base64data',
      );
    });

    test('cria OrderModel com dados corretos', () {
      expect(order.id, 'order-123');
      expect(order.status, 'delivered');
      expect(order.total, 11.0);
      expect(order.copyAndPaste, 'PIX123abc');
      expect(order.items.length, 1);
    });

    test('tem datas configuradas', () {
      expect(order.createdDateTime, isNotNull);
      expect(order.overdueDateTime, isNotNull);
      expect(order.createdDateTime!.isBefore(order.overdueDateTime), true);
    });

    test('usa toJson (não tojson)', () {
      final json = order.toJson();
      expect(json['id'], 'order-123');
      expect(json['status'], 'delivered');
      expect(json['total'], 11.0);
      expect(json['copiaecola'], 'PIX123abc');
    });

    test('desserializa de JSON corretamente', () {
      final json = order.toJson();
      final restored = OrderModel.fromJson(json);
      expect(restored.id, order.id);
      expect(restored.status, order.status);
      expect(restored.total, order.total);
      expect(restored.copyAndPaste, 'PIX123abc');
      expect(restored.items.length, order.items.length);
    });

    test('toString contém dados relevantes', () {
      final str = order.toString();
      expect(str.contains('order-123'), true);
      expect(str.contains('delivered'), true);
    });
  });
}
