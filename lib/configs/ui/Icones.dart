import 'package:flutter/foundation.dart';

class IconesAplicacao {
  static String _comum({@required String nomeIcone}) {
    return 'assets/pictures/$nomeIcone.png';
  }

  static String _svg({@required String nomeIcone}) {
    return 'assets/pictures/$nomeIcone.svg';
  }

  static String get iconeErro => _comum(nomeIcone: 'icone_erro');
  static String get iconeOlho => _comum(nomeIcone: 'icone_olho');

  static String get logo => _svg(nomeIcone: 'logo');
}
