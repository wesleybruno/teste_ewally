import 'package:dartz/dartz.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/features/home/repository/saldo_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';

class BuscarExtratoUseCase {
  final SaldoRepository _saldoRepository;

  BuscarExtratoUseCase({
    @required SaldoRepository saldoRepository,
  }) : _saldoRepository = saldoRepository;

  Future<Either<ApiResult, ExtratoModel>> call(
      String periodoInicio, String periodoFim) async {
    return await _saldoRepository.buscarExtrato(
      periodoInicio,
      periodoFim,
    );
  }
}
