import 'package:dio/dio.dart';

abstract class HttpMethodos {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

/// Controla se o app opera em modo demo (sem backend) ou conectado a API.
/// true = usa dados locais mockados para demonstracao.
/// false = faz requisicoes reais ao backend (Back4App).
const bool kDemoMode = true;

class HttpManager {
  final String _restApiKey;
  final String _appId;

  HttpManager({
    String? restApiKey,
    String? appId,
  })  : _restApiKey = restApiKey ?? const String.fromEnvironment(
          'PARSE_REST_API_KEY',
          defaultValue: 'rFBKU8tk0m5ZlKES2CGieOaoYz6TgKxVMv8jRIsN',
        ),
        _appId = appId ?? const String.fromEnvironment(
          'PARSE_APP_ID',
          defaultValue: 'g1Oui3JqxnY4S1ykpQWHwEKGOe0dRYCPvPF4iykc',
        );

  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    if (kDemoMode) {
      // Em modo demo, retorna vazio. Os repositories usam dados locais.
      return {};
    }

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json; charset=utf-8',
        'accept': 'application/json',
        if (_restApiKey.isNotEmpty)
          'X-Parse-REST-API-Key': _restApiKey,
        if (_appId.isNotEmpty)
          'X-Parse-Application-Id': _appId,
      });

    Dio dio = Dio();
    try {
      Response response = await dio.request(
        url,
        options: Options(headers: defaultHeaders, method: method),
        data: body,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }
}
