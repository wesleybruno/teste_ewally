import 'package:dartz/dartz.dart';
import 'package:ewally/features/home/models/saldo_model.dart';
import 'package:ewally/features/home/repository/saldo_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';

class BuscarSaldoUseCase {
  final SaldoRepository _saldoRepository;

  BuscarSaldoUseCase({
    @required SaldoRepository saldoRepository,
  }) : _saldoRepository = saldoRepository;

  Future<Either<ApiResult, SaldoModel>> call() async {
    return await _saldoRepository.buscarSaldo();
  }
}
