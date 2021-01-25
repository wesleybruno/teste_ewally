abstract class ValidadorCampoTexto {
  bool isTextoValido({String texto});
}

class ValidadorApelido extends ValidadorCampoTexto {
  @override
  bool isTextoValido(
      {int tamanhoMinimo = 6, String texto, bool podeEspacoBranco = false}) {
    if (texto == null) {
      return false;
    }

    if (texto.contains(" ") && !podeEspacoBranco) {
      return false;
    }

    if (texto.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    return texto.length >= tamanhoMinimo;
  }
}

class ValidadorTamanho extends ValidadorCampoTexto {
  @override
  bool isTextoValido({int tamanhoMinimo = 6, String texto}) {
    if (texto == null) {
      return false;
    }

    return texto.length >= tamanhoMinimo;
  }
}

class ValidadorFormatoData extends ValidadorCampoTexto {
  @override
  bool isTextoValido({String texto}) {
    if (texto == null) {
      return false;
    }

    final regex = RegExp(
        r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$");
    return regex.hasMatch(texto);
  }
}

class ValidadorEmail extends ValidadorCampoTexto {
  @override
  bool isTextoValido({String texto}) {
    if (texto == null) {
      return false;
    }

    final regex = RegExp(
        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");

    return regex.hasMatch(texto);
  }
}

class ValidadorPassword extends ValidadorCampoTexto {
  @override
  bool isTextoValido({String texto}) {
    if (texto == null) {
      return false;
    }

    return texto.length > 5;
  }
}
