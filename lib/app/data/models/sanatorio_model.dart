// To parse this JSON data, do
//
//     final sanatorioModel = sanatorioModelFromJson(jsonString);

import 'dart:convert';

import 'package:fupa_aliados/app/data/models/sanatorio_producto_model.dart';

SanatorioModel sanatorioModelFromJson(String str) =>
    SanatorioModel.fromJson(json.decode(str));

String sanatorioModelToJson(SanatorioModel data) => json.encode(data.toJson());

class SanatorioModel {
  SanatorioModel({
    this.idsanatorio,
    this.descripcion,
    this.direccion,
    this.telefono,
    this.correo,
    this.ciudad,
    this.coordenadas,
    this.habilitado,
    this.nrosucursal,
    this.productos,
  });

  int idsanatorio;
  String descripcion;
  dynamic direccion;
  String telefono;
  String correo;
  dynamic ciudad;
  String coordenadas;
  bool habilitado;
  int nrosucursal;
  List<SanatorioProductoModel> productos;

  factory SanatorioModel.fromJson(Map<String, dynamic> json) => SanatorioModel(
        idsanatorio: json["idsanatorio"],
        descripcion: json["descripcion"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        correo: json["correo"],
        ciudad: json["ciudad"],
        coordenadas: json["coordenadas"],
        habilitado: json["habilitado"],
        nrosucursal: json["nrosucursal"],
        productos: json["productos"] == null
            ? null
            : SanatorioProductoModel.fromJsonList(json["productos"]),
      );

  Map<String, dynamic> toJson() => {
        "idsanatorio": idsanatorio,
        "descripcion": descripcion,
        "direccion": direccion,
        "telefono": telefono,
        "correo": correo,
        "ciudad": ciudad,
        "coordenadas": coordenadas,
        "habilitado": habilitado,
        "nrosucursal": nrosucursal,
        "productos": productos == null
            ? null
            : List<SanatorioProductoModel>.from(productos.map((x) => x)),
      };
}
