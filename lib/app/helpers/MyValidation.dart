class MyValidation {
  dynamic validar(
      {var valorActual,
      var listaValoresCheckBox,
      var valorInicial,
      List codigosValidacion,
      List rangoEdad,
      var tipo}) {
    //String listaErrores = "";
    //COMENT
    String error;
    for (var i = 0; i < codigosValidacion.length; i++) {
      switch (codigosValidacion[i]) {
        case "1":
          error = _inputRequerido(
              valor: valorActual,
              valorInicial: valorInicial,
              valores: listaValoresCheckBox,
              tipo: tipo);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "2":
          error = _formatoAlfabetico(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "3":
          error = _formatoNumerico(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "4":
          error = _formatoCorreoElectronico(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "5":
          error = _longitudRequerida(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "6":
          error = _formatoAlfanumerico(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "7":
          error = _rangoEdad(valor: valorActual, rango: rangoEdad);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "8":
          print("CASE 8 >>>>>>>>>");
          error = _fechaCompletaSeleccionada(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "9":
          error = _formatoCorreoElectronicoNumeroTelefonico(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        case "10":
          error = _formatoNumeroTelefonico(valor: valorActual);
          if (error != null) {
            return error;
          }
          //error == null ? listaErrores = listaErrores + "" : listaErrores = listaErrores + error;
          break;
        default:
          print("validación no implementada");
      }
    }

    /*if (listaErrores.isEmpty) {
      return null;
    } else {
      return listaErrores;
    }*/
  }

  String _inputRequerido({var valor, var valorInicial, var valores, var tipo}) {
    var tipoInput;
    if (tipo == null) {
      if (valorInicial == null && valor != null) {
        tipoInput = "0"; //POR VALOR VACIO "TextField"
      } else {
        if (valorInicial != null && valores == null) {
          tipoInput = "1"; //POR VALOR DIFERENTE AL INICIAL "Radio & Dropdown"
        } else {
          tipoInput =
              "2"; //POR UNA O VARIAS OPCIONES NO SELECCIONADAS "CheckBox"
        }
      }
    } else {
      switch (tipo) {
        case "text":
          tipoInput = "0";
          break;
        case "email":
          tipoInput = "0";
          break;
        case "phone":
          tipoInput = "0";
          break;
        case "password":
          tipoInput = "0";
          break;
        case "radio":
          tipoInput = "1";
          break;
        case "select":
          tipoInput = "1";
          break;
        case "checkbox":
          tipoInput = "2";
          break;
        case "date":
          tipoInput = "3";
          break;
        default:
          print("tipo de input no reconocido");
      }
    }

    switch (tipoInput) {
      case "0":
        return _textFieldRequerido(valor);
        break;
      case "1":
        return _radioOrDropDownRequerido(valor, valorInicial);
        break;
      case "2":
        return _checkBoxGroupRequerido(valores);
        break;
      case "3":
        return _dateGroupRequerido(valor: valor);
        break;
      default:
        print("validación 'requerido' no implementada.");
        return null;
    }
  }

  String _textFieldRequerido(var valor) {
    print("validar TextField requerido $valor");
    if (valor.isEmpty) {
      return "Por favor, ingresa este campo. ";
    } else {
      return null;
    }
  }

  String _radioOrDropDownRequerido(var valor, var valorInicial) {
    print("validar Radio/DropDown requerido $valorInicial vs $valor");
    if (valor != valorInicial && valor != null) {
      return null;
    } else {
      return "Por favor, selecciona una opción. ";
    }
  }

  String _checkBoxGroupRequerido(var valores) {
    print("validar CheckBox requerido");
    var auxError;
    var contadorAux = 0;
    valores.forEach((key, value) {
      if (value != true) {
        //DO NOTHING
      } else {
        contadorAux++;
      }
    });

    if (contadorAux > 0) {
      auxError = null;
    } else {
      auxError = "Por favor, selecciona por lo menos una opción. ";
    }
    return auxError;
  }

  String _dateGroupRequerido({var valor}) {
    String dia = valor[0] ?? valor["dias"];
    String mes = valor[1] ?? valor["meses"];
    String ano = valor[2] ?? valor["anos"];
    print("VALIDAR DATE REQUERIDO");

    if (dia.toLowerCase() == "día" &&
        mes.toLowerCase() == "mes" &&
        ano.toLowerCase() == "año") {
      return "Por favor, selecciona una fecha. ";
    } else {
      return null;
    }
  }

  String _formatoCorreoElectronico({String valor}) {
    var emailPattern = r"[aA-zZ0-9._%+-]+@[aA-zZ0-9.-]+\.[aA-zZ]{2,7}$";
    RegExp myEmailRegex = RegExp(emailPattern);
    if (myEmailRegex.hasMatch(valor) || valor == "") {
      return null;
    } else {
      return "Por favor, ingresa un correo válido. ";
    }
  }

  String _formatoNumeroTelefonico({String valor}) {
    var phonePattern = r"^[0-9\+]{1}[0-9\s]+$";
    RegExp myPhoneRegex = RegExp(phonePattern);

    print(valor);
    if (!valor.startsWith("+5959") &&
        !valor.startsWith("5959") &&
        !valor.startsWith("09")) {
      return "Por favor, ingresa un teléfono válido. ";
    }
    if ((myPhoneRegex.hasMatch(valor) &&
            (valor.length <= 13) &&
            (valor.length >= 9)) ||
        valor == "") {
      return null;
    } else {
      return "Por favor, ingresa un teléfono válido. ";
    }
  }

  String _formatoCorreoElectronicoNumeroTelefonico({String valor}) {
    String errorCorreo = _formatoCorreoElectronico(valor: valor);
    String errorTelefono = _formatoNumeroTelefonico(valor: valor);
    if (errorCorreo == null) {
      return null;
    } else {
      if (errorTelefono == null) {
        return null;
      } else {
        return "Por favor, ingresa un correo o teléfono válido. ";
      }
    }
  }

  String _formatoAlfanumerico({String valor}) {
    var alphanumericPattern = r"^[0-9a-zA-ZñÑáéíóúüÁÉÍÓÚÜ'\-_\s]+$";
    RegExp myAlphanumericRegex = RegExp(alphanumericPattern);
    if (myAlphanumericRegex.hasMatch(valor) || valor == "") {
      return null;
    } else {
      print("formato alfanumerico inválido");
      return "Por favor, ingresa un formato válido. ";
    }
  }

  String _formatoAlfabetico({String valor}) {
    //var alphabeticPattern = r"^[ñÑüÜ\-_]{0}[a-zA-ZñÑáéíóúüÁÉÍÓÚÜ'\-_\s][ñÑüÜ\'\-_]{0}$";
    var alphabeticPattern2 =
        r"^[a-zA-ZáéíóúÁÉÍÓÚ'\s]{1,}[ñÑüÜ'\-_\s]{0,}[a-zA-ZáéíóúÁÉÍÓÚ\s]{1,}$";
    RegExp myAlphabeticRegex = RegExp(alphabeticPattern2);
    if (myAlphabeticRegex.hasMatch(valor) || valor == "") {
      return null;
    } else {
      print("formato alfabetico inválido");
      return "Por favor, ingresa un formato válido. ";
    }
  }

  String _formatoNumerico({String valor}) {
    if (valor == null) {
      return "Por favor, ingresa un formato válido. ";
    }
    return double.tryParse(valor) != null
        ? null
        : "Por favor, ingresa un formato válido. ";
  }

  String _rangoEdad({String valor, List rango}) {
    int edad = int.tryParse(valor);
    int minimo = int.parse(rango[0]);
    int maximo = int.parse(rango[1]);
    if (edad == null) {
      return "Por favor, ingresa una edad válida en años. ";
    } else {
      if (edad >= minimo && edad <= maximo) {
        return null;
      } else {
        return "Debes tener mínimo ${rango[0]} años y ${rango[1]} años como maximo. ";
      }
    }
  }

  String _fechaCompletaSeleccionada({var valor}) {
    //print(valor);
    print("GET DATE DATA >>>>>>>>>");
    String dia = valor[0] ?? valor["dias"];
    String mes = valor[1] ?? valor["meses"];
    String ano = valor[2] ?? valor["anos"];
    int aux = 0;
    print("VALIDAR DATE INCOMPLETO $dia / $mes / $ano >>>>>>>>>");

    if (dia.toLowerCase() == "día" &&
        mes.toLowerCase() == "mes" &&
        ano.toLowerCase() == "año") {
      aux = 2;
    }

    if (dia.toLowerCase() != "día" &&
        (mes.toLowerCase() == "mes" || ano.toLowerCase() == "año")) {
      aux = 1;
    }

    if (mes.toLowerCase() != "mes" &&
        (dia.toLowerCase() == "día" || ano.toLowerCase() == "año")) {
      aux = 1;
    }

    if (ano.toLowerCase() != "año" &&
        (dia.toLowerCase() == "día" || mes.toLowerCase() == "mes")) {
      aux = 1;
    }

    if (aux == 1) {
      return "Por favor, completá la fecha. ";
    } else {
      if (aux == 2) {
        return "Este campo es obligatorio.";
      } else {
        return null;
      }
    }
  }

  String _longitudRequerida({String valor}) {
    if (valor.length < 6) {
      return "Por favor, ingresa mínimo 6 caracteres. ";
    } else {
      return null;
    }
  }
}
