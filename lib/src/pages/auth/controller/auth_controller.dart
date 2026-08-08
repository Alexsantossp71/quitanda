import 'package:get/get.dart';
import 'package:greengrocery/src/constants/storage_keys.dart';
import 'package:greengrocery/src/models/user_model.dart';
import 'package:greengrocery/src/pages/auth/repositories/auth_repository.dart';
import 'package:greengrocery/src/pages/auth/result/auth_result.dart';
import 'package:greengrocery/src/pages_routes/app_pages.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.singInRoute);
      return;
    } else {
      AuthResult result = await authRepository.validateToken(token);

      result.when(
        success: (user) {
          this.user = user;
          saveTokenAndProceedToBase();
        },
        error: (message) {
          signOut();
        },
      );
    }
  }

  void saveTokenAndProceedToBase() {
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> signOut() async {
    user = UserModel();
    await utilsServices.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.singInRoute);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    await authRepository.resetPassword(email);
    isLoading.value = false;
  }
}
