import 'package:greengrocery/src/config/demo_data.dart';
import 'package:greengrocery/src/models/order_model.dart';
import 'package:greengrocery/src/pages/orders/orders_result/orders_result.dart';

/// Provides mock orders for demo mode.
class DemoOrdersRepository {
  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return OrdersResult<List<OrderModel>>.success(demoOrders);
  }
}
