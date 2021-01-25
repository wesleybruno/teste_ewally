import 'package:dartz/dartz.dart';
import 'package:ewally/configs/utils/ApiResult.dart';
import 'package:ewally/features/login/model/dados_invalidos_model.dart';
import 'package:ewally/features/login/model/token_model.dart';
import 'package:meta/meta.dart';
import 'package:ewally/configs/ui/Strings.dart';

class LoginDecodeHelper {
  Either<ApiResult, TokenModel> decodeLogin({@required ApiResult result}) {
    try {
      if (result is Success) {
        final tokenModel = TokenModel.fromJson(result.data);
        return Right(tokenModel);
      }

      if (result is Failure) {
        final dadosInvalidos = DadosInvalidosModel.fromJson(result.data);
        result.data = dadosInvalidos.toJson();
      }

      return Left(result);
    } catch (e) {
      result.message = Strings.erroAoDecodificar('LoginDecodeHelper');
      return Left(result);
    }
  }
}
