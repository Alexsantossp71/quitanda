import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future getCartItems({required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getCartItems,
      method: HttpMethodos.post,
      headers: {'X-Parse-Session-Token': token},
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      print(result['result']);
    } else {
      print('EERRRROO');
    }
  }
}
