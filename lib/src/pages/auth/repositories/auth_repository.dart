import 'package:greengrocery/src/config/demo_mode.dart';
import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/user_model.dart';
import 'package:greengrocery/src/pages/auth/repositories/auth_errors.dart'
    as authErrors;
import 'package:greengrocery/src/pages/auth/result/auth_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';
import 'package:greengrocery/src/pages/auth/repositories/demo_auth_repository.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  final DemoAuthRepository _demoRepo = DemoAuthRepository();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorString(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    if (kDemoMode) {
      return _demoRepo.validateToken(token);
    }

    final result = await _httpManager.restRequest(
        url: EndPoints.validadeToken,
        method: HttpMethodos.post,
        headers: {
          'X-Parse-Session-Token': token,
        });

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    if (kDemoMode) {
      return _demoRepo.signIn(email: email, password: password);
    }

    final result = await _httpManager
        .restRequest(url: EndPoints.signin, method: HttpMethodos.post, body: {
      'email': email,
      'password': password,
    });

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    if (kDemoMode) {
      return _demoRepo.signUp(user);
    }

    final result = await _httpManager.restRequest(
        url: EndPoints.signup,
        method: HttpMethodos.post,
        body: user.toJson());

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    if (kDemoMode) {
      return _demoRepo.resetPassword(email);
    }

    await _httpManager.restRequest(
        url: EndPoints.resetPassword,
        method: HttpMethodos.post,
        body: {'email': email});
  }
}
