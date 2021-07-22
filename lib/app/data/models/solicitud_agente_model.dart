// To parse this JSON data, do
//
//     final solicitudAgenteModel = solicitudAgenteModelFromMap(jsonString);

import 'package:fupa_aliados/app/data/models/adjunto_solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'dart:convert';

import 'estado_solicitud_agente_model.dart';

class SolicitudAgenteModel {
  SolicitudAgenteModel({
    this.idsolicitudagente,
    this.cliente,
    this.username,
    this.monto,
    this.cantidadcuota,
    this.tipovivienda,
    this.lugartrabajo,
    this.direcciontrabajo,
    this.telefonotrabajo,
    this.ciudadtrabajo,
    this.cargo,
    this.antiguedad,
    this.salario,
    this.profesion,
    this.ramo,
    this.seccion,
    this.otrosingresos,
    this.activos,
    this.referencia1,
    this.comentario1,
    this.referencia2,
    this.comentario2,
    this.estadosolicitudagente,
    this.fechasolicitud,
    this.fechaaprobacion,
    this.fechaconfirmacion,
    this.fecharechazo,
    this.motivorechazo,
    this.observaciones,
    this.destino,
    this.adjuntos,
  });

  int idsolicitudagente;
  ClienteModel cliente;
  String username;
  double monto;
  int cantidadcuota;
  String tipovivienda;
  String lugartrabajo;
  String direcciontrabajo;
  String telefonotrabajo;
  String ciudadtrabajo;
  String cargo;
  String antiguedad;
  String salario;
  String profesion;
  String ramo;
  String seccion;
  String otrosingresos;
  String activos;
  String referencia1;
  String telefonoReferencia1;
  String comentario1;
  String referencia2;
  String telefonoReferencia2;
  dynamic comentario2;
  EstadosolicitudagenteModel estadosolicitudagente;
  String fechasolicitud;
  String fechaaprobacion;
  String fechaconfirmacion;
  String fecharechazo;
  String motivorechazo;
  String observaciones;
  String destino;
  List<AdjuntoSolicitudAgenteModel> adjuntos;

  factory SolicitudAgenteModel.fromJson(String str) =>
      SolicitudAgenteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SolicitudAgenteModel.fromMap(Map<String, dynamic> json) =>
      SolicitudAgenteModel(
        idsolicitudagente: json["idsolicitudagente"],
        cliente: ClienteModel.fromJson(json["cliente"]),
        username: json["username"],
        monto: json["monto"],
        cantidadcuota: json["cantidadcuota"],
        tipovivienda: json["tipovivienda"],
        lugartrabajo: json["lugartrabajo"],
        direcciontrabajo: json["direcciontrabajo"],
        telefonotrabajo: json["telefonotrabajo"],
        ciudadtrabajo: json["ciudadtrabajo"],
        cargo: json["cargo"],
        antiguedad: json["antiguedad"],
        salario: json["salario"],
        profesion: json["profesion"],
        ramo: json["ramo"],
        seccion: json["seccion"],
        otrosingresos: json["otrosingresos"],
        activos: json["activos"],
        referencia1: json["referencia1"],
        comentario1: json["comentario1"],
        referencia2: json["referencia2"],
        comentario2: json["comentario2"],
        estadosolicitudagente:
            EstadosolicitudagenteModel.fromMap(json["estadosolicitudagente"]),
        fechasolicitud: json["fechasolicitud"],
        fechaaprobacion: json["fechaaprobacion"],
        fechaconfirmacion: json["fechaconfirmacion"],
        fecharechazo: json["fecharechazo"],
        motivorechazo: json["motivorechazo"],
        observaciones: json["observaciones"],
        destino: json["destino"],
        adjuntos: List<AdjuntoSolicitudAgenteModel>.from(json["adjuntos"]
            .map((x) => AdjuntoSolicitudAgenteModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "idsolicitudagente": idsolicitudagente,
        "cliente": cliente.toJson(),
        "username": username,
        "monto": monto,
        "cantidadcuota": cantidadcuota,
        "tipovivienda": tipovivienda,
        "lugartrabajo": lugartrabajo,
        "direcciontrabajo": direcciontrabajo,
        "telefonotrabajo": telefonotrabajo,
        "ciudadtrabajo": ciudadtrabajo,
        "cargo": cargo,
        "antiguedad": antiguedad,
        "salario": salario,
        "profesion": profesion,
        "ramo": ramo,
        "seccion": seccion,
        "otrosingresos": otrosingresos,
        "activos": activos,
        "referencia1": referencia1,
        "comentario1": comentario1,
        "referencia2": referencia2,
        "comentario2": comentario2,
        "estadosolicitudagente": estadosolicitudagente == null
            ? null
            : estadosolicitudagente.toJson(),
        "fechasolicitud": fechasolicitud,
        "fechaaprobacion": fechaaprobacion,
        "fechaconfirmacion": fechaconfirmacion,
        "fecharechazo": fecharechazo,
        "motivorechazo": motivorechazo,
        "observaciones": observaciones,
        "destino": destino,
        "adjuntos": adjuntos == null
            ? null
            : List<dynamic>.from(adjuntos.map((x) => x.toMap())),
      };

  static List<SolicitudAgenteModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return [];

    List<SolicitudAgenteModel> list = [];

    for (var item in jsonList) {
      final p = SolicitudAgenteModel.fromMap(item);
      list.add(p);
    }
    return list;
  }
}
