import 'package:dartz/dartz.dart';
import 'package:ewally/features/login/model/login_model.dart';
import 'package:ewally/features/login/model/token_model.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/login/datasource/login_datasource.dart';
import 'package:ewally/features/login/repository/login_decode_helper.dart';

class LoginRepository {
  LoginRepository({
    @required loginDataSource,
    @required loginDecodeHelper,
  })  : _dataSource = loginDataSource,
        _decodeHelper = loginDecodeHelper;

  final ILoginDataSource _dataSource;
  final LoginDecodeHelper _decodeHelper;

  Future<Either<ApiResult, TokenModel>> realizarLogin(
    String username,
    String password,
  ) async {
    final loginModel = LoginModel(
      username: username,
      password: password,
    );

    final result = await this._dataSource.realizarLogin(
          body: loginModel.toJson(),
        );
    return _decodeHelper.decodeLogin(result: result);
  }

  void salvarCabecalhosLocal(
    String bearerToken,
  ) async {
    this._dataSource.salvarCabecalhosLocal(bearerToken);
  }

  Future<void> limparCabecalhosLocal() async {
    await this._dataSource.limparCabecalhosLocal();
  }

  Future<TokenModel> buscarCabecalhosLocal() async {
    final bearerToken = await this._dataSource.buscarCabecalhoLocal();

    final cabecalho = TokenModel(
      token: bearerToken,
    );

    return cabecalho;
  }
}
