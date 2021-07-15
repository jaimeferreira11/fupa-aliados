// To parse this JSON data, do
//
//     final destinoSolicitudAgenteModel = destinoSolicitudAgenteModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DestinoSolicitudAgenteModel {
  DestinoSolicitudAgenteModel({
    @required this.iddestinosolicitudagente,
    @required this.descripcion,
    @required this.estado,
    @required this.fondo,
  });

  int iddestinosolicitudagente;
  String descripcion;
  bool estado;
  int fondo;

  factory DestinoSolicitudAgenteModel.fromJson(String str) =>
      DestinoSolicitudAgenteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DestinoSolicitudAgenteModel.fromMap(Map<String, dynamic> json) =>
      DestinoSolicitudAgenteModel(
        iddestinosolicitudagente: json["iddestinosolicitudagente"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        fondo: json["fondo"],
      );

  Map<String, dynamic> toMap() => {
        "iddestinosolicitudagente": iddestinosolicitudagente,
        "descripcion": descripcion,
        "estado": estado,
        "fondo": fondo,
      };

  static List<DestinoSolicitudAgenteModel> fromJsonList(
      List<dynamic> jsonList) {
    if (jsonList == null) return [];

    List<DestinoSolicitudAgenteModel> list = [];

    for (var item in jsonList) {
      final p = DestinoSolicitudAgenteModel.fromMap(item);
      list.add(p);
    }
    return list;
  }
}
