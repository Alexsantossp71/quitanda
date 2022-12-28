import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:greengrocery/src/models/order_model.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocery/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocery/src/pages/orders/view/components/repository/orders_repository.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class AllOrdersControler extends GetxController {
  List<OrderModel> allOrders = [];
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );
    result.when(
      success: (orders) {
        allOrders = orders;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
