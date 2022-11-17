import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/pages/home/result/home_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class HomeRepository {
  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final HttpManager _httpManager = HttpManager();

    final result = await _httpManager.restRequest(
      url: EndPoints.getAllCategories,
      method: HttpMethodos.post,
    );

    if (result['result'] != null) {
      // lista
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      // Erro
      return HomeResult.error('Erro ao carregar as categorias');
    }
  }
}
