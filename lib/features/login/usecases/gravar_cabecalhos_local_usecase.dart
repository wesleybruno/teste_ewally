import 'package:flutter/foundation.dart';
import 'package:ewally/features/login/repository/login_repository.dart';

class GravarCabecalhosLocalLoginUseCase {
  final LoginRepository _loginRepository;

  GravarCabecalhosLocalLoginUseCase({
    @required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  void call(String bearerToken) {
    return _loginRepository.salvarCabecalhosLocal(bearerToken);
  }
}
