import 'package:dio/dio.dart';

abstract class HttpMethodos {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  final String _restApiKey;
  final String _appId;

  HttpManager({
    String? restApiKey,
    String? appId,
  })  : _restApiKey = restApiKey ?? const String.fromEnvironment(
          'PARSE_REST_API_KEY',
          defaultValue: '',
        ),
        _appId = appId ?? const String.fromEnvironment(
          'PARSE_APP_ID',
          defaultValue: '',
        );

  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
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
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
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
