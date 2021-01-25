import 'package:dartz/dartz.dart';
import 'package:ewally/features/login/model/token_model.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/login/repository/login_repository.dart';

class RealizarLoginUseCase {
  final LoginRepository _loginRepository;

  RealizarLoginUseCase({
    @required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  Future<Either<ApiResult, TokenModel>> call(
    String email,
    String password,
  ) async {
    return await _loginRepository.realizarLogin(email, password);
  }
}
