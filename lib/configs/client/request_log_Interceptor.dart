import 'package:dio/dio.dart';

class ResquestLogInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    print(
        "REQUEST[${options?.method}] => PATH: ${options.baseUrl + options?.path} \n DATA: ${options.data} \n HEADERS: ${options.headers}");
    return options;
  }

  @override
  onResponse(Response response) {
    print(
        "RESPONSE[${response?.statusCode}] => PATH: ${response.request.baseUrl + response?.request?.path} \n RESULT: ${response.data} \n HEADERS: ${response.headers}");
    return super.onResponse(response);
  }

  @override
  onError(DioError e) {
    print(
        "ERROR[${e?.response?.statusCode}] => PATH: ${e.request.baseUrl + e?.request?.path} \n DATA: ${e.response.data}");
    return super.onError(e);
  }
}
