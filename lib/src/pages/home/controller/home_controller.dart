import 'package:get/get.dart';
import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/home/repository/home_repository.dart';
import 'package:greengrocery/src/pages/home/result/home_result.dart';
import 'package:greengrocery/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();
  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  List<ItemModel> allProducts = [];
  UtilsServices utilsServices = UtilsServices();
  CategoryModel? currentCategory;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false);
    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        if (allCategories.isEmpty) return;
        selectCategory(allCategories.first);
        //print("TODAS AS CATEGORIAS : $allCategories");
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  } //fim do getall categories

  Future<void> getAllProducts() async {
    setLoading(true);

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itensPerPage': itemsPerPage,
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false);
    result.when(
      success: (data) {
        //allProducts.assignAll(data);
        //if (allProducts.isEmpty) return;
        //selectProduct(allProducts.first);

        print(data);
        print(' O pagination');
        print(currentCategory!.pagination);
        print('O ID');
        print(currentCategory!.id);
      },
      error: (message) {
        print('TENTANDO IMPRIMIR O ERRO');
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  } // fim do getallproducts

} //fim da class
