import 'package:flutter/material.dart';
import 'package:ewally/configs/ui/Strings.dart';
import 'package:ewally/widgets/error_widgets/generic_error_widget.dart';

class ErroApiWidget extends GenericErrorWidget {
  final Function aoApertarTentarNovamente;
  final Color corTexto;
  final Color corIcone;

  const ErroApiWidget({
    Key key,
    this.aoApertarTentarNovamente,
    this.corTexto,
    this.corIcone,
  }) : super(
          key: key,
          aoApertarTentarNovamente: aoApertarTentarNovamente,
          semanticText: Strings.problemasComServidor,
          corIcone: corIcone,
          corTexto: corTexto,
          iconeErro: Icons.error,
          textoBotao: Strings.tentarNovamente,
          textoExplicativo: Strings.desculpe,
          textoPrincipal: Strings.tenteMaisTarde,
        );
}
