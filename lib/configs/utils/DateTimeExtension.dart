import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final _format = DateFormat('dd-MM-yyyy');

extension FormatadorDateTimeToString on DateTime {
  String get formatarDataString {
    if (this == null) {
      return '';
    }
    return _format.format(this);
  }

  String get yyyyMMddSeparadoComTraco {
    return DateFormat('yyy-MM-dd').format(this);
  }

  String get formatarDateTimeEmPtBr {
    if (this == null) {
      return '';
    }
    initializeDateFormatting('pt_BR', null);
    final formatted = DateFormat('dd - MMMM - yyyy', 'pt_Br')
        .format(this)
        .replaceAll('-', 'de');
    return formatted;
  }

  String get formatarDateTimeEmDia {
    if (this == null) {
      return '';
    }
    initializeDateFormatting('pt_BR', null);
    final formatted = DateFormat('EEEE', 'pt_Br')
        .format(this)
        .replaceAll(RegExp(r'\-(.*)'), '');

    return '${formatted[0].toUpperCase()}${formatted.substring(1)}';
  }

  String get formatarDataParaDiaMesAnoEHoras {
    return DateFormat(
      "dd 'de' MMMM 'de' yyyy • 'às' HH:mm",
      'pt_BR',
    ).format(this).toUpperCase();
  }

  String get formatarDataParaDiaDoMes {
    return DateFormat(
      "dd 'de' MMMM",
      'pt_BR',
    ).format(this).toUpperCase();
  }

  String get formatarTimestamp {
    return DateFormat(
      'ddMMyyyyhhmmss',
      'pt_BR',
    ).format(this);
  }
}

extension FormatadorStringToDateTime on String {
  String get primeiroNumero {
    if (this == null) {
      return '';
    }
    final dateTime = DateTime.parse(this);
    initializeDateFormatting('pt_BR', null);
    final formatted = DateFormat('dd').format(dateTime);
    return formatted;
  }

  String get formatarDataString {
    if (this == null) {
      return '';
    }
    final dateTime = DateTime.parse(this);
    return _format.format(dateTime);
  }

  String get yyyyMMddSeparadoComTraco {
    final dateTime = DateTime.parse(this);
    return DateFormat('yyy-MM-dd').format(dateTime);
  }

  String get formatarDateTimeEmPtBr {
    if (this == null) {
      return '';
    }
    final dateTime = DateTime.parse(this);
    initializeDateFormatting('pt_BR', null);
    final formatted = DateFormat('dd - MMMM - yyyy', 'pt_Br')
        .format(dateTime)
        .replaceAll('-', 'de');
    return formatted;
  }

  String get formatarDateTimeEmDia {
    if (this == null) {
      return '';
    }
    final dateTime = DateTime.parse(this);
    initializeDateFormatting('pt_BR', null);
    final formatted = DateFormat('EEEE', 'pt_Br')
        .format(dateTime)
        .replaceAll(RegExp(r'\-(.*)'), '');

    return '${formatted[0].toUpperCase()}${formatted.substring(1)}';
  }

  String get formatarDataParaDiaMesAnoEHoras {
    final dateTime = DateTime.parse(this);
    return DateFormat(
      "dd 'de' MMMM 'de' yyyy • 'às' HH:mm",
      'pt_BR',
    ).format(dateTime).toUpperCase();
  }

  String get formatarDataParaDiaDoMes {
    final dateTime = DateTime.parse(this);
    return DateFormat(
      "dd 'de' MMMM",
      'pt_BR',
    ).format(dateTime).toUpperCase();
  }

  String get formatarTimestamp {
    final dateTime = DateTime.parse(this);
    return DateFormat(
      'ddMMyyyyhhmmss',
      'pt_BR',
    ).format(dateTime);
  }
}
