import 'package:get/get.dart';
import 'package:greengrocery/src/pages/base/controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NavigationController());
  }
}
