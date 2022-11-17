import 'package:get/get.dart';
import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/pages/home/repository/home_repository.dart';
import 'package:greengrocery/src/pages/home/result/home_result.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class HomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();
  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  UtilsServices utilsServices = UtilsServices();

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false);
    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        print("TODAS AS CATEGORIAS : $allCategories");
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
