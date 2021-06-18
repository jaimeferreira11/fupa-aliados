// To parse this JSON data, do
//
//     final sanatorioProductoModel = sanatorioProductoModelFromJson(jsonString);

import 'dart:convert';

SanatorioProductoModel sanatorioProductoModelFromJson(String str) =>
    SanatorioProductoModel.fromJson(json.decode(str));

String sanatorioProductoModelToJson(SanatorioProductoModel data) =>
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

  static List<SanatorioProductoModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return [];

    List<SanatorioProductoModel> list = [];

    for (var item in jsonList) {
      final p = SanatorioProductoModel.fromJson(item);
      list.add(p);
    }
    return list;
  }
}
