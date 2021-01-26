import 'package:dartz/dartz.dart';
import 'package:ewally/features/home/datasource/saldo_datasource.dart';
import 'package:ewally/features/home/models/buscar_extrato_model.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/features/home/models/saldo_model.dart';
import 'package:ewally/features/home/repository/extrato_decode_helper.dart';
import 'package:ewally/features/home/repository/saldo_decode_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';

class SaldoRepository {
  SaldoRepository({
    @required saldoDataSource,
    @required saldoDecodeHelper,
    @required extratoDecodeHelper,
  })  : _dataSource = saldoDataSource,
        _decodeHelper = saldoDecodeHelper,
        _extratoDecodeHelper = extratoDecodeHelper;

  final ISaldoDataSource _dataSource;
  final SaldoDecodeHelper _decodeHelper;
  final ExtratoDecodeHelper _extratoDecodeHelper;

  Future<Either<ApiResult, SaldoModel>> buscarSaldo() async {
    final result = await this._dataSource.buscarSaldo();
    return _decodeHelper.decodeSaldo(result: result);
  }

  Future<Either<ApiResult, ExtratoModel>> buscarExtrato(
    String initialDate,
    String finalDate,
  ) async {
    final buscarExtratoModel = BuscarExtratoModel.fromDataString(
      initialDate,
      finalDate,
    );

    final result = await this._dataSource.buscarExtrato(
          map: buscarExtratoModel.toJson(),
        );
    return _extratoDecodeHelper.decodeExtrato(result: result);
  }
}
