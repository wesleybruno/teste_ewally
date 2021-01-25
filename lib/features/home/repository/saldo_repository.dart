import 'package:dartz/dartz.dart';
import 'package:ewally/features/home/datasource/saldo_datasource.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/features/home/models/saldo_model.dart';
import 'package:ewally/features/home/repository/extrato_decode_helper.dart';
import 'package:ewally/features/home/repository/saldo_decode_helper.dart';
import 'package:ewally/features/login/model/login_model.dart';
import 'package:ewally/features/login/model/token_model.dart';
import 'package:flutter/foundation.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/login/datasource/login_datasource.dart';
import 'package:ewally/features/login/repository/login_decode_helper.dart';

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
    final result = await this._dataSource.buscarExtrato(
          initialDate,
          finalDate,
        );
    return _extratoDecodeHelper.decodeExtrato(result: result);
  }
}