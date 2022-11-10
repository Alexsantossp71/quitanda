import 'package:get/get.dart';
import 'package:greengrocery/src/pages/auth/repositories/auth_repository.dart';
import 'package:greengrocery/src/pages/auth/result/auth_result.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(success: (user) {
      print(user);
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
      print(message);
    });
  }
}
