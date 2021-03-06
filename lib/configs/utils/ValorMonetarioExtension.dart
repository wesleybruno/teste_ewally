import 'package:intl/intl.dart';

final _formatter = NumberFormat.currency(
  locale: 'pt_BR',
  symbol: r'R$',
  decimalDigits: 2,
);

extension ValorMonetario on num {
  String get emReal {
    return _formatter.format(this / 100);
  }

  String get emRealSemSimbolo {
    return _formatter
        .format(this / 100)
        .replaceAll(r'R$', '')
        .replaceAll(' ', '');
  }

  String get emRealComSinal {
    String valorFormatado = _formatter.format(this / 100).replaceAll('-', '');
    if (this > 0) {
      valorFormatado = '+ ' + valorFormatado;
    } else if (this < 0) {
      valorFormatado = '- ' + valorFormatado;
    }
    return valorFormatado;
  }
}
