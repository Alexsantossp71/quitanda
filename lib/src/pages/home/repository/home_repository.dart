import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class HomeRepository {
  getAllCategories() async {
    final HttpManager _httpManager = HttpManager();

    final result = await _httpManager.restRequest(
      url: EndPoints.getAllCategories,
      method: HttpMethodos.post,
    );

    if (result['result'] != null) {
      // lista
    } else {
      // Erro
    }
  }
}
