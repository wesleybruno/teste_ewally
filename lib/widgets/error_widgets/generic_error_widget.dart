import 'package:flutter/material.dart';
import 'package:ewally/configs/ui/Cores.dart';
import 'package:ewally/configs/ui/DimensoesTela.dart';
import 'package:ewally/configs/ui/Fontes.dart';
import 'package:ewally/widgets/botao_principal/botao_principal.dart';

class GenericErrorWidget extends StatelessWidget {
  final Function aoApertarTentarNovamente;
  final String textoPrincipal;
  final String textoExplicativo;
  final String semanticText;
  final String textoBotao;
  final Color corTexto;
  final IconData iconeErro;
  final Color corIcone;

  const GenericErrorWidget({
    Key key,
    this.aoApertarTentarNovamente,
    this.textoPrincipal,
    this.textoExplicativo,
    this.semanticText,
    this.textoBotao,
    this.corTexto,
    this.iconeErro,
    this.corIcone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 100.h,
            ),
            width: 50.w,
            height: 50.h,
            child: Icon(
              iconeErro,
              color: corIcone ?? Cores.preto,
              size: 48.h,
              semanticLabel: semanticText,
            ),
          ),
          Container(
            width: 350.w,
            margin: EdgeInsets.only(
              top: 40.h,
              bottom: 30.h,
            ),
            child: Text(
              textoPrincipal,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.ssp,
                color: corTexto ?? Cores.preto,
                fontFamily: Fontes.montserrat,
                fontWeight: Fontes.normal,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 45.h,
            ),
            width: 320.w,
            child: Text(
              textoExplicativo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.ssp,
                color: corTexto ?? Cores.cinza[200],
                fontFamily: Fontes.montserrat,
                fontWeight: Fontes.normal,
              ),
            ),
          ),
          BotaoPrincipal(
            texto: textoBotao,
            corTexto: Cores.preto,
            aoClicar: aoApertarTentarNovamente,
            altura: 55.h,
            largura: 266.w,
          )
        ],
      ),
    );
  }
}
