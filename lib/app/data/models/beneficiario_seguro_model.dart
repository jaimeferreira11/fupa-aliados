import 'dart:io';

import 'package:fupa_aliados/app/data/models/persona_model.dart';
import 'dart:convert';

class BeneficiarioSeguroModel {
  BeneficiarioSeguroModel(
      {this.idbeneficiarioseguro,
      this.idsolicitudseguro,
      this.persona,
      this.adjunto1,
      this.adjunto2,
      this.idparentezco,
      this.filesList});

  int idbeneficiarioseguro;
  int idsolicitudseguro;
  PersonaModel persona;
  int idparentezco;
  String adjunto1;
  String adjunto2;
  List<File> filesList;

  factory BeneficiarioSeguroModel.fromJson(String str) =>
      BeneficiarioSeguroModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BeneficiarioSeguroModel.fromMap(Map<String, dynamic> json) =>
      BeneficiarioSeguroModel(
        idbeneficiarioseguro: json["idbeneficiarioseguro"],
        idsolicitudseguro: json["idsolicitudseguro"],
        persona: PersonaModel.fromJson(json["persona"]),
        adjunto1: json["adjunto1"],
        adjunto2: json["adjunto2"],
        idparentezco: json["idparentezco"],
      );

  Map<String, dynamic> toMap() => {
        "idbeneficiarioseguro": idbeneficiarioseguro,
        "idsolicitudseguro": idsolicitudseguro,
        "persona": persona.toJson(),
        "adjunto2": adjunto2,
        "adjunto1": adjunto1,
        "idparentezco": idparentezco,
      };

  static List<BeneficiarioSeguroModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return [];

    List<BeneficiarioSeguroModel> list = [];

    for (var item in jsonList) {
      final p = BeneficiarioSeguroModel.fromMap(item);
      list.add(p);
    }
    return list;
  }
}
