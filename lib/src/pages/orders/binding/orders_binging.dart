import 'package:get/get.dart';
import 'package:greengrocery/src/pages/orders/controller/all_orders_controler.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AllOrdersControler());
  }
}
