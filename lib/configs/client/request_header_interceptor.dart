import 'package:dio/dio.dart';
import 'package:ewally/features/splash/usecases/buscar_cabecalhos_local_usecase.dart';
import 'package:ewally/injection_container.dart';

class RequestHeaderInterceptor extends Interceptor {
  RequestHeaderInterceptor();

  @override
  Future onRequest(RequestOptions options) async {
    final _buscarCabecalhosLocalLoginUseCase =
        dependencia<BuscarCabecalhosLocalLoginUseCase>();
    final cabecalho = await _buscarCabecalhosLocalLoginUseCase();
    options.headers["Authorization"] = 'Bearer ${cabecalho.token}';
    return options;
  }
}
