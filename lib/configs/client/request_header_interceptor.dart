import 'package:dio/dio.dart';

class RequestHeaderInterceptor extends Interceptor {
  RequestHeaderInterceptor();

  @override
  Future onRequest(RequestOptions options) async {
    // final _buscarCabecalhosLocalLoginUseCase =
    //     dependencia<BuscarCabecalhosLocalLoginUseCase>();
    // final cabecalho = await _buscarCabecalhosLocalLoginUseCase();
    // options.headers["Bearer"] = cabecalho.token;
    return options;
  }
}
