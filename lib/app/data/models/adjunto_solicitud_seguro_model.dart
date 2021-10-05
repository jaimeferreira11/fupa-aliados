import 'dart:convert';

import 'package:flutter/material.dart';

class AdjuntoSolicitudSeguroModel {
  AdjuntoSolicitudSeguroModel({
    @required this.idadjuntosolicitudagente,
    @required this.idsolicitudagente,
    @required this.tipo,
    @required this.adjunto,
    @required this.estado,
    @required this.fechalog,
  });

  int idadjuntosolicitudagente;
  int idsolicitudagente;
  String tipo;
  String adjunto;
  bool estado;
  int fechalog;

  factory AdjuntoSolicitudSeguroModel.fromJson(String str) =>
      AdjuntoSolicitudSeguroModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdjuntoSolicitudSeguroModel.fromMap(Map<String, dynamic> json) =>
      AdjuntoSolicitudSeguroModel(
        idadjuntosolicitudagente: json["idadjuntosolicitudagente"],
        idsolicitudagente: json["idsolicitudagente"],
        tipo: json["tipo"],
        adjunto: json["adjunto"],
        estado: json["estado"],
        fechalog: json["fechalog"],
      );

  Map<String, dynamic> toMap() => {
        "idadjuntosolicitudagente": idadjuntosolicitudagente,
        "idsolicitudagente": idsolicitudagente,
        "tipo": tipo,
        "adjunto": adjunto,
        "estado": estado,
        "fechalog": fechalog,
      };
}
