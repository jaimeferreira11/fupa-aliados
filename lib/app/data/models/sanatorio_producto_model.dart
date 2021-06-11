// To parse this JSON data, do
//
//     final sanatorioModel = sanatorioModelFromJson(jsonString);

import 'dart:convert';

SanatorioProductoModel sanatorioModelFromJson(String str) =>
    SanatorioProductoModel.fromJson(json.decode(str));

String sanatorioModelToJson(SanatorioProductoModel data) =>
    json.encode(data.toJson());

class SanatorioProductoModel {
  SanatorioProductoModel({
    this.idsanatorio,
    this.descripcion,
    this.idsanatorioproducto,
    this.estado,
  });

  int idsanatorio;
  String descripcion;
  int idsanatorioproducto;
  bool estado;

  factory SanatorioProductoModel.fromJson(Map<String, dynamic> json) =>
      SanatorioProductoModel(
        idsanatorio: json["idsanatorio"],
        descripcion: json["descripcion"],
        idsanatorioproducto: json["idsanatorioproducto"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "idsanatorio": idsanatorio,
        "descripcion": descripcion,
        "idsanatorioproducto": idsanatorioproducto,
        "estado": estado,
      };
}
