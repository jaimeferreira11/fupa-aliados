// To parse this JSON data, do
//
//     final clienteModel = clienteModelFromJson(jsonString);

import 'dart:convert';

import 'package:fupa_aliados/app/data/models/persona_model.dart';

ClienteModel clienteModelFromJson(String str) =>
    ClienteModel.fromJson(json.decode(str));

String clienteModelToJson(ClienteModel data) => json.encode(data.toJson());

class ClienteModel {
  ClienteModel({
    this.idcliente,
    this.persona,
    this.estado,
  });

  int idcliente;
  PersonaModel persona;
  bool estado;

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        idcliente: json["idcliente"],
        persona: PersonaModel.fromJson(json["persona"]),
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "idcliente": idcliente,
        "persona": persona.toJson(),
        "estado": estado,
      };
}
