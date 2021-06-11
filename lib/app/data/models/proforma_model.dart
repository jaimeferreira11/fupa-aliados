import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/sanatorio_model.dart';

class ProformaModel {
  final int idproforma;
  final int idpersona;
  final ClienteModel cliente;
  final double monto;
  int plazo;
  String periodicidad;
  int nrosucursal;
  final String codigo;
  final String usuario;
  int idsanatorioproducto;

  ProformaModel({
    this.idproforma,
    this.idpersona,
    this.cliente,
    this.monto,
    this.plazo,
    this.periodicidad,
    this.nrosucursal,
    this.codigo,
    this.usuario,
    this.idsanatorioproducto,
  });

  Map<String, dynamic> toJson() {
    return {
      'idproforma': idproforma,
      'idpersona': idpersona,
      'monto': monto,
      'plazo': plazo,
      'periodicidad': periodicidad,
      'nrosucursal': nrosucursal,
      'codigo': codigo,
      'usuario': usuario,
      'idsanatorioproducto': idsanatorioproducto,
      "cliente": cliente == null ? null : cliente.toJson(),
    };
  }

  static ProformaModel fromJson(Map<String, dynamic> map) {
    return ProformaModel(
        idproforma: map['idproforma'],
        idpersona: map['idpersona'],
        monto: map['monto'],
        plazo: map['plazo'],
        periodicidad: map['periodicidad'],
        nrosucursal: map['nrosucursal'],
        codigo: map['codigo'],
        usuario: map['usuario'],
        idsanatorioproducto: map['idsanatorioproducto'],
        cliente: map["cliente"] == null
            ? null
            : ClienteModel.fromJson(map["cliente"]));
  }

  static List<ProformaModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return [];

    List<ProformaModel> list = [];

    for (var item in jsonList) {
      final p = ProformaModel.fromJson(item);
      list.add(p);
    }
    return list;
  }
}
