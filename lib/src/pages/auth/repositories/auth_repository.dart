import 'package:dio/dio.dart';
import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/user_model.dart';
import 'package:greengrocery/src/pages/auth/repositories/auth_errors.dart'
    as authErrors;
import 'package:greengrocery/src/pages/auth/result/auth_result.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final result = await _httpManager
        .restRequest(url: EndPoints.signin, method: HttpMethodos.post, body: {
      "email": email,
      "password": password,
    });

    if (result['result'] != null) {
      print('NO IF ');

      final user = UserModel.fromJson(result['result']);
      print('Signin funcionou');
      print(result['result']);

      return AuthResult.success(user);
    } else {
      print('NO ELSE ');

      print(result['error']);
      print('Signin não funcionou 222');

      return AuthResult.error(authErrors.authErrorString(result['error']));
    }
  }
}
