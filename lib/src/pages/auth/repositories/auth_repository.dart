import 'package:dio/dio.dart';
import 'package:greengrocery/src/constants/endpoints.dart';
import 'package:greengrocery/src/models/user_model.dart';
import 'package:greengrocery/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  Future signIn({required String email, required String password}) async {
    final result = await _httpManager
        .restRequest(url: EndPoint.signin, method: HttpMethodos.post, body: {
      "email": email,
      "password": password,
    });
//////////////////////////////////////////////////////////////////////////////////////////////////////////
    Map<String, String> oresult = {
      "id": "ejFjPEFQ8y",
      "fullname": "GreenGrocer",
      "email": "greengrocerteste@gmail.com",
      "phone": "(99) 99999-9999",
      "cpf": "123.456.789-10",
      "token": "r:f5b4c100861717699e5709aecdf384c7"
    };
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (result['result'] == null) {
      print('ESTA LOGADO');
      print('Response status:');
      print(result['result']);
      result['result'] = oresult;
      final user = UserModel.fromJson(result['result']);
      print(user);
    } else {
      // print('Response status: ${result.statusCode}');
      print('Não LOGOU');
      print(result['error']);
      print(result['code']);
      // result['result'] = oresult;

    }
  }
}
