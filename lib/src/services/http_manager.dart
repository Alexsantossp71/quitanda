import 'package:dio/dio.dart';

abstract class HttpMethodos {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    // Headers da requisiçao

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json; charset=utf-8',
        'accept': 'application/json',
        'X-Parse-REST-API-Key': 'rFBKU8tk0m5ZlKES2CGieOaoYz6TgKxVMv8jRIsN',
        'X-Parse-Application-Id': 'g1Oui3JqxnY4S1ykpQWHwEKGOe0dRYCPvPF4iykc',
      });

    Dio dio = Dio();
    try {
      Response response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: 'post',
        ),
        data: body,
      );

      return response.data;
    } on DioError catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }
}
