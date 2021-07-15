import 'dart:convert';

import 'package:flutter/material.dart';

class EstadosolicitudagenteModel {
  EstadosolicitudagenteModel({
    @required this.idestadosolicitudagente,
    @required this.descripcion,
  });

  int idestadosolicitudagente;
  String descripcion;

  factory EstadosolicitudagenteModel.fromJson(String str) =>
      EstadosolicitudagenteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EstadosolicitudagenteModel.fromMap(Map<String, dynamic> json) =>
      EstadosolicitudagenteModel(
        idestadosolicitudagente: json["idestadosolicitudagente"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "idestadosolicitudagente": idestadosolicitudagente,
        "descripcion": descripcion,
      };
}
