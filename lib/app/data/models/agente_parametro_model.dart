// To parse this JSON data, do
//
//     final agenteParametroModel = agenteParametroModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AgenteParametroModel {
  AgenteParametroModel({
    @required this.idagenteparametro,
    @required this.montomax,
    @required this.cuotasmax,
    @required this.montomin,
    @required this.cuotasmin,
    @required this.tasa,
    @required this.estado,
    @required this.fondo,
  });

  int idagenteparametro;
  double montomax;
  int cuotasmax;
  double montomin;
  int cuotasmin;
  double tasa;
  bool estado;
  int fondo;

  factory AgenteParametroModel.fromJson(String str) =>
      AgenteParametroModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AgenteParametroModel.fromMap(Map<String, dynamic> json) =>
      AgenteParametroModel(
        idagenteparametro: json["idagenteparametro"],
        montomax: json["montomax"],
        cuotasmax: json["cuotasmax"],
        montomin: json["montomin"],
        cuotasmin: json["cuotasmin"],
        tasa: json["tasa"],
        estado: json["estado"],
        fondo: json["fondo"],
      );

  Map<String, dynamic> toMap() => {
        "idagenteparametro": idagenteparametro,
        "montomax": montomax,
        "cuotasmax": cuotasmax,
        "montomin": montomin,
        "cuotasmin": cuotasmin,
        "tasa": tasa,
        "estado": estado,
        "fondo": fondo,
      };
}
