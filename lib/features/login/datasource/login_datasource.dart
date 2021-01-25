import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/configs/utils/Endpoint.dart';
import 'package:ewally/configs/utils/LocalStorage.dart';
import 'package:ewally/configs/utils/RequestApiProvider.dart';

abstract class ILoginDataSource {
  Future<ApiResult> realizarLogin({Map<String, dynamic> body});
  Future<void> salvarCabecalhosLocal(
    String bearerToken,
  );
  Future<dynamic> buscarCabecalhoLocal();
  Future<void> limparCabecalhosLocal();
}

class LoginDataSource implements ILoginDataSource {
  final RequestApiProvider _requestApiProvider;
  final ILocalStorage _localStorage;

  LoginDataSource({
    @required apiProvider,
    @required localStorage,
  })  : _requestApiProvider = apiProvider,
        _localStorage = localStorage;

  @override
  Future<ApiResult> realizarLogin({Map<String, dynamic> body}) async {
    return await _requestApiProvider.execute(
      Endpoint(
        data: body,
        method: EndPointMethod.post,
        url: '/user/login',
      ),
    );
  }

  @override
  Future<void> salvarCabecalhosLocal(
    String bearerToken,
  ) async {
    await this._localStorage.save('bearerToken', bearerToken);
  }

  @override
  Future<void> limparCabecalhosLocal() async {
    await this._localStorage.remove('bearerToken');
  }

  @override
  Future<dynamic> buscarCabecalhoLocal() async {
    return await this._localStorage.read('bearerToken');
  }
}
