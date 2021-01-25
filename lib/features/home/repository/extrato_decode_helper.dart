import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/home/models/dados_invalidos_model.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:meta/meta.dart';
import 'package:ewally/configs/ui/Strings.dart';

class ExtratoDecodeHelper {
  Either<ApiResult, ExtratoModel> decodeExtrato({@required ApiResult result}) {
    try {
      if (result is Success) {
        final saldoModel = ExtratoModel.fromJson(result.data);
        return Right(saldoModel);
      }

      if (result is Failure) {
        final dadosInvalidos = DadosInvalidosModel.fromJson(result.data);
        result.data = dadosInvalidos.toJson();
      }

      return Left(result);
    } catch (e) {
      result.message = Strings.erroAoDecodificar('ExtratoModel');
      return Left(result);
    }
  }
}
