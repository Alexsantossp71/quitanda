import 'package:greengrocery/src/config/demo_data.dart';
import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/home/result/home_result.dart';

/// Provides mock data for home tab when in demo mode.
class DemoHomeRepository {
  Future<HomeResult<CategoryModel>> getAllCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return HomeResult<CategoryModel>.success(demoCategories);
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final String? searchTitle = body['title'] as String?;
    final String? categoryId = body['categoryId'] as String?;

    List<ItemModel> filtered = List.from(demoProducts);

    if (categoryId != null && categoryId.isNotEmpty) {
      final cat = demoCategories.firstWhere(
        (c) => c.id == categoryId,
        orElse: () => demoCategories.first,
      );
      filtered = cat.items.toList();
    }

    if (searchTitle != null && searchTitle.isNotEmpty) {
      final lower = searchTitle.toLowerCase();
      filtered = filtered
          .where((p) => p.itemName.toLowerCase().contains(lower))
          .toList();
    }

    return HomeResult<ItemModel>.success(filtered);
  }
}
