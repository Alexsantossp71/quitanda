import 'package:get/get.dart';
import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/home/repository/home_repository.dart';
import 'package:greengrocery/src/pages/home/result/home_result.dart';
import 'package:greengrocery/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  //List<ItemModel> allProducts = [];
  UtilsServices utilsServices = UtilsServices();
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  RxString searchTitle = ''.obs;

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (_) {
        filterByTitle();
      },
      time: const Duration(milliseconds: 600),
    );
    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) return;
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true, isProduct: true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false, isProduct: true);
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

/////////////////////////////////////////////////////////////////////
// buscando produtos

  void filterByTitle() {
    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
// apagar todos osprodutos das categorias
      for (var category in allCategories) {
        currentCategory!.items.clear();
        category.pagination = 0;
      }

      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == '');

      if (c == null) {
        //criar uma nova categoria com todos
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = allCategories.first;
    update();
    getAllProducts();
  }

  ///

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts();
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itensPerPage': itemsPerPage,
    };

    // metodo que procura pelo nome o produto

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false);
    result.when(
      success: (data) {
        currentCategory!.items.addAll(data);
        print(currentCategory!.items);
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
