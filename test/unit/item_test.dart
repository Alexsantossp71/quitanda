import 'package:flutter_test/flutter_test.dart';
import 'package:greengrocery/src/models/item_model.dart';

void main() {
  group('ItemModel', () {
    late ItemModel item;

    setUp(() {
      item = ItemModel(
        id: 'item-1',
        itemName: 'Maçã Gala',
        imgUrl: 'https://example.com/apple.png',
        price: 5.49,
        unit: 'kg',
        description: 'Maçã gala fresca e selecionada.',
      );
    });

    test('cria ItemModel com dados corretos', () {
      expect(item.id, 'item-1');
      expect(item.itemName, 'Maçã Gala');
      expect(item.imgUrl, 'https://example.com/apple.png');
      expect(item.price, 5.49);
      expect(item.unit, 'kg');
      expect(item.description, isNotEmpty);
    });

    test('serializa para JSON corretamente', () {
      final json = item.toJson();
      expect(json['id'], 'item-1');
      expect(json['title'], 'Maçã Gala');
      expect(json['picture'], 'https://example.com/apple.png');
      expect(json['price'], 5.49);
      expect(json['unit'], 'kg');
    });

    test('desserializa de JSON corretamente', () {
      final json = item.toJson();
      final restored = ItemModel.fromJson(json);
      expect(restored.id, item.id);
      expect(restored.itemName, item.itemName);
      expect(restored.price, item.price);
    });

    test('usa id vazio como default', () {
      final defaultItem = ItemModel(
        description: 'desc',
        itemName: 'Nome',
        imgUrl: 'url',
        price: 1.0,
        unit: 'un',
      );
      expect(defaultItem.id, '');
    });

    test('serialização round-trip preserva dados', () {
      final json = item.toJson();
      final restored = ItemModel.fromJson(json);
      expect(restored.toJson(), json);
    });
  });
}
