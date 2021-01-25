import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/configs/utils/Endpoint.dart';
import 'package:ewally/configs/utils/RequestApiProvider.dart';

abstract class ISaldoDataSource {
  Future<ApiResult> buscarExtrato({Map<String, dynamic> map});
  Future<ApiResult> buscarSaldo();
}

class SaldoDataSource implements ISaldoDataSource {
  final RequestApiProvider _requestApiProvider;

  SaldoDataSource({
    @required apiProvider,
  }) : _requestApiProvider = apiProvider;

  @override
  Future<ApiResult> buscarSaldo() async {
    return await _requestApiProvider.execute(
      Endpoint(
        data: null,
        method: EndPointMethod.get,
        url: '/account/balance',
      ),
    );
  }

  @override
  Future<ApiResult> buscarExtrato({Map<String, dynamic> map}) async {
    return await _requestApiProvider.execute(
      Endpoint(
        data: null,
        queryParameters: <String, dynamic>{
          'initialDate': map["initialDate"],
          'finalDate': map["finalDate"]
        },
        method: EndPointMethod.get,
        url: '/b2b/statement',
      ),
    );
  }
}
