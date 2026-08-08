import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/home/result/home_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';
import 'package:greengrocery/src/models/app_data.dart' as demo;

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  bool get _isDemo => kDemoMode;

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    if (_isDemo) {
      await Future.delayed(const Duration(milliseconds: 300));
      List<CategoryModel> demoCategories = demo.categories
          .map((name) => CategoryModel(id: name.toLowerCase(), name: name, items: []))
          .toList();
      return HomeResult<CategoryModel>.success(demoCategories);
    }
    final result = await _httpManager.restRequest(
      url: EndPoints.getAllCategories,
      method: HttpMethodos.post,
    );
    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error('Erro ao carregar as categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    //final HttpManager _httpManager = HttpManager();

    final result = await _httpManager.restRequest(
      url: EndPoints.getAllProdutcs,
      method: HttpMethodos.post,
      body: body,
    );

    if (result['result'] != null) {
      // lista
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(ItemModel.fromJson)
          .toList();
      return HomeResult<ItemModel>.success(data);
    } else {
      // Erro
      return HomeResult.error('Erro ao carregar itens.');
    }
  }

  /// fim da  class
}
