import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/home/models/dados_invalidos_model.dart';
import 'package:ewally/features/home/models/saldo_model.dart';
import 'package:meta/meta.dart';
import 'package:ewally/configs/ui/Strings.dart';

class SaldoDecodeHelper {
  Either<ApiResult, SaldoModel> decodeSaldo({@required ApiResult result}) {
    try {
      if (result is Success) {
        final saldoModel = SaldoModel.fromJson(result.data);
        return Right(saldoModel);
      }

      if (result is Failure) {
        final dadosInvalidos = DadosInvalidosModel.fromJson(result.data);
        result.data = dadosInvalidos.toJson();
      }

      return Left(result);
    } catch (e) {
      result.message = Strings.erroAoDecodificar('SaldoDecodeHelper');
      return Left(result);
    }
  }
}
