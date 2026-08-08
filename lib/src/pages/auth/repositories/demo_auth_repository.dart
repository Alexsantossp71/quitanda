import 'package:greengrocery/src/config/demo_data.dart';
import 'package:greengrocery/src/models/user_model.dart';
import 'package:greengrocery/src/pages/auth/result/auth_result.dart';

/// Provides mock authentication for demo mode.
class DemoAuthRepository {
  Future<AuthResult> validateToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return AuthResult.success(demoUser);
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AuthResult.success(demoUser);
  }

  Future<AuthResult> signUp(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AuthResult.success(demoUser);
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
