//import 'package:dio/dio.dart';
import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/user_model.dart';
import 'package:greengrocery/src/pages/auth/repositories/auth_errors.dart'
    as authErrors;
import 'package:greengrocery/src/pages/auth/result/auth_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class AuthRepository {
  // valida token
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorString(result['error']));
    }
  }

// TESTA SE TEM TOKEN

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.validadeToken,
        method: HttpMethodos.post,
        headers: {
          'X-Parse-Session-Token': token,
        });

    return handleUserOrError(result);
  }

  /// TESTA O SING IN

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager
        .restRequest(url: EndPoints.signin, method: HttpMethodos.post, body: {
      'email': email,
      'password': password,
    });

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
        url: EndPoints.signup,
        method: HttpMethodos.post,
        // o que vai enviar
        body: user.toJson());

    return handleUserOrError(result);
  }

  // reseta a senha

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
        url: EndPoints.resetPassword,
        method: HttpMethodos.post,
        // o que vai enviar
        body: {'email': email});
  }
}
