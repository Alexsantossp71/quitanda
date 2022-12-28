import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/order_model.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocery/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class OrderRepository {
  final _httpManager = HttpManager();
  final authController = AuthController();

  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required String userId, required String token}) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getAllOrders,
      method: HttpMethodos.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token
        //authController.user.token
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não foi possível recuperar os pedidos');
    }
  }
}
