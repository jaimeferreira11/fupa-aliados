// To parse this JSON data, do
//
//     final solicitudAgenteModel = solicitudAgenteModelFromMap(jsonString);

import 'package:fupa_aliados/app/data/models/adjunto_solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'dart:convert';

import 'adjunto_solicitud_seguro_model.dart';
import 'beneficiario_seguro_model.dart';
import 'estado_solicitud_agente_model.dart';

class SolicitudSeguroModel {
  SolicitudSeguroModel({
    this.idsolicitudseguro,
    this.cliente,
    this.username,
    this.monto,
    this.cantidadcuota,
    this.tiposeguro,
    this.fechasolicitud,
    this.fechaaprobacion,
    this.fechaconfirmacion,
    this.fecharechazo,
    this.motivorechazo,
    this.observaciones,
    this.adjuntos,
    this.beneficiarios,
    this.estado,
    this.tipovivienda,
    this.lugartrabajo,
    this.direcciontrabajo,
    this.telefonotrabajo,
    this.ciudadtrabajo,
    this.cargo,
    this.antiguedad,
    this.salario,
  });

  int idsolicitudseguro;
  ClienteModel cliente;
  String username;
  double monto;
  int cantidadcuota;
  String tiposeguro;
  EstadosolicitudagenteModel estado;
  String fechasolicitud;
  String fechaaprobacion;
  String fechaconfirmacion;
  String fecharechazo;
  String motivorechazo;
  String observaciones;
  String tipovivienda;
  String lugartrabajo;
  String direcciontrabajo;
  String telefonotrabajo;
  String ciudadtrabajo;
  String cargo;
  String antiguedad;
  String salario;
  List<AdjuntoSolicitudSeguroModel> adjuntos;
  List<BeneficiarioSeguroModel> beneficiarios;

  factory SolicitudSeguroModel.fromJson(String str) =>
      SolicitudSeguroModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SolicitudSeguroModel.fromMap(Map<String, dynamic> json) =>
      SolicitudSeguroModel(
        idsolicitudseguro: json["idsolicitudseguro"],
        cliente: ClienteModel.fromJson(json["cliente"]),
        username: json["username"],
        monto: json["monto"],
        cantidadcuota: json["cantidadcuota"],
        tiposeguro: json["tiposeguro"],
        estado: EstadosolicitudagenteModel.fromMap(json["estado"]),
        fechasolicitud: json["fechasolicitud"],
        fechaaprobacion: json["fechaaprobacion"],
        fechaconfirmacion: json["fechaconfirmacion"],
        fecharechazo: json["fecharechazo"],
        motivorechazo: json["motivorechazo"],
        observaciones: json["observaciones"],
        lugartrabajo: json["lugartrabajo"],
        direcciontrabajo: json["direcciontrabajo"],
        telefonotrabajo: json["telefonotrabajo"],
        ciudadtrabajo: json["ciudadtrabajo"],
        cargo: json["cargo"],
        antiguedad: json["antiguedad"],
        salario: json["salario"],
        adjuntos: List<AdjuntoSolicitudSeguroModel>.from(json["adjuntos"]
            .map((x) => AdjuntoSolicitudSeguroModel.fromMap(x))),
        beneficiarios: List<BeneficiarioSeguroModel>.from(json["beneficiarios"]
            .map((x) => BeneficiarioSeguroModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idsolicitudseguro": idsolicitudseguro,
        "cliente": cliente.toJson(),
        "username": username,
        "monto": monto,
        "cantidadcuota": cantidadcuota,
        "tiposeguro": tiposeguro,
        "estado": estado == null ? null : estado.toMap(),
        "fechasolicitud": fechasolicitud,
        "fechaaprobacion": fechaaprobacion,
        "fechaconfirmacion": fechaconfirmacion,
        "fecharechazo": fecharechazo,
        "motivorechazo": motivorechazo,
        "observaciones": observaciones,
        "tipovivienda": tipovivienda,
        "lugartrabajo": lugartrabajo,
        "direcciontrabajo": direcciontrabajo,
        "telefonotrabajo": telefonotrabajo,
        "ciudadtrabajo": ciudadtrabajo,
        "cargo": cargo,
        "antiguedad": antiguedad,
        "salario": salario,
        "adjuntos": adjuntos == null
            ? null
            : List<dynamic>.from(adjuntos.map((x) => x.toMap())),
        "beneficiarios": beneficiarios == null
            ? null
            : List<dynamic>.from(beneficiarios.map((x) => x.toMap())),
      };

  static List<SolicitudSeguroModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return [];

    List<SolicitudSeguroModel> list = [];

    for (var item in jsonList) {
      final p = SolicitudSeguroModel.fromMap(item);
      list.add(p);
    }
    return list;
  }
}
