import 'package:flutter_test/flutter_test.dart';
import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/models/item_model.dart';

void main() {
  group('CategoryModel', () {
    late ItemModel item1;
    late ItemModel item2;
    late CategoryModel category;

    setUp(() {
      item1 = ItemModel(
        id: 'i1',
        itemName: 'Maca',
        imgUrl: 'https://example.com/apple.png',
        price: 5.49,
        unit: 'kg',
        description: 'Maca fresca',
      );
      item2 = ItemModel(
        id: 'i2',
        itemName: 'Banana',
        imgUrl: 'https://example.com/banana.png',
        price: 3.29,
        unit: 'kg',
        description: 'Banana prata',
      );
      category = CategoryModel(
        title: 'Frutas',
        id: 'frutas',
        items: [item1, item2],
        pagination: 1,
      );
    });

    test('cria CategoryModel com dados corretos', () {
      expect(category.title, 'Frutas');
      expect(category.id, 'frutas');
      expect(category.items.length, 2);
      expect(category.pagination, 1);
    });

    test('serializa para JSON', () {
      final json = category.toJson();
      expect(json['title'], 'Frutas');
      expect(json['id'], 'frutas');
      expect(json['pagination'], 1);
      expect((json['items'] as List).length, 2);
    });

    test('desserializa de JSON', () {
      final json = category.toJson();
      final restored = CategoryModel.fromJson(json);
      expect(restored.title, 'Frutas');
      expect(restored.id, 'frutas');
      expect(restored.items.length, 2);
      expect(restored.pagination, 1);
    });

    test('serializacao round-trip preserva dados', () {
      final json = category.toJson();
      final restored = CategoryModel.fromJson(json);
      expect(restored.toJson(), json);
    });

    test('usa valores default para items e pagination', () {
      final json = {
        'title': 'Legumes',
        'id': 'legumes',
      };
      final cat = CategoryModel.fromJson(json);
      expect(cat.title, 'Legumes');
      expect(cat.id, 'legumes');
      expect(cat.items, isEmpty);
      expect(cat.pagination, 0);
    });

    test('serializa items corretamente', () {
      final json = category.toJson();
      final itemsJson = json['items'] as List;
      expect(itemsJson[0]['title'], 'Maca');
      expect(itemsJson[1]['title'], 'Banana');
    });

    test('toString contem informacoes relevantes', () {
      final str = category.toString();
      expect(str, contains('Frutas'));
      expect(str, contains('frutas'));
    });
  });
}
