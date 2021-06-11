// To parse this JSON data, do
//
//     final personaModel = personaModelFromJson(jsonString);

import 'dart:convert';

PersonaModel personaModelFromJson(String str) =>
    PersonaModel.fromJson(json.decode(str));

String personaModelToJson(PersonaModel data) => json.encode(data.toJson());

class PersonaModel {
  PersonaModel({
    this.idpersona,
    this.nrodoc,
    this.nombres,
    this.apellidos,
    this.estado,
    this.telefono1,
    this.telefono2,
    this.fechanaciemiento,
    this.codtipopersona,
    this.direccion,
    this.email,
  });

  int idpersona;
  String nrodoc;
  String nombres;
  String apellidos;
  dynamic estado;
  String telefono1;
  String telefono2;
  dynamic fechanaciemiento;
  int codtipopersona;
  dynamic direccion;
  dynamic email;

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
        idpersona: json["idpersona"],
        nrodoc: json["nrodoc"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        estado: json["estado"],
        telefono1: json["telefono1"],
        telefono2: json["telefono2"],
        fechanaciemiento: json["fechanaciemiento"],
        codtipopersona: json["codtipopersona"],
        direccion: json["direccion"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "idpersona": idpersona,
        "nrodoc": nrodoc,
        "nombres": nombres,
        "apellidos": apellidos,
        "estado": estado,
        "telefono1": telefono1,
        "telefono2": telefono2,
        "fechanaciemiento": fechanaciemiento,
        "codtipopersona": codtipopersona,
        "direccion": direccion,
        "email": email,
      };
}
