import 'package:ewally/features/login/model/token_model.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/features/login/repository/login_repository.dart';

class BuscarCabecalhosLocalLoginUseCase {
  final LoginRepository _loginRepository;

  BuscarCabecalhosLocalLoginUseCase({
    @required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  Future<TokenModel> call() async {
    return await _loginRepository.buscarCabecalhosLocal();
  }
}
