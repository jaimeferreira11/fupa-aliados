import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/agente_parametro_model.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/destino_solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/persona_model.dart';
import 'package:fupa_aliados/app/data/models/proforma_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_seguro_model.dart';
import 'package:fupa_aliados/app/data/models/token_model.dart';
import 'package:fupa_aliados/app/data/models/usuario_model.dart';
import 'package:fupa_aliados/app/data/providers/remote/server_api.dart';
import 'package:get/get.dart';

class ServerRepository {
  final ServerAPI _api = Get.find<ServerAPI>();

  Future<Either<Failure, UsuarioModel>> verfificarSession() =>
      _api.verificarSession();

  Future<Either<Failure, TokenModel>> login(String username, String password) =>
      _api.login(username, password);

  Future<Either<Failure, UsuarioModel>> obtenerUserInfo(String token) =>
      _api.obtenerUserInfo(token);

  Future<Either<Failure, String>> actualizarUsuario(UsuarioModel user) =>
      _api.actualizarUsuario(user);

  Future<void> logout() => _api.logout();

  Future<Either<Failure, String>> cambiarPassword(
          String password, String newpassword) =>
      _api.cambiarPassword(password, newpassword);

  Future<Either<Failure, String>> sendMail(String asunto, String mensaje) =>
      _api.sendMail(asunto, mensaje);

  Future<Either<Failure, int>> getVersion() => _api.getVersion();

  // Microfranquicias
  Future<Either<Failure, ClienteModel>> verificarDisponibilidadCliente(
          String tipoDoc, String doc) =>
      _api.verificarDisponibilidadCliente(tipoDoc, doc);

  Future<Either<Failure, String>> solicitarCodigoVerificacion(
          {int idpersona, String cel, String monto, String plazo}) =>
      _api.solicitarCodigoVerificacion(
          idpersona: idpersona, cel: cel, monto: monto, plazo: plazo);

  Future<Either<Failure, bool>> reenviarCodigo(String numero, String mensaje) =>
      _api.reenviarCodigo(numero, mensaje);

  Future<Either<Failure, String>> enviarSolicitud(
          String numero, ProformaModel proforma) =>
      _api.enviarSolicitud(numero, proforma);

  Future<Either<Failure, List<ProformaModel>>> obtenerSolicitudes(
          int mes, int anio) =>
      _api.obtenerSolicitudes(mes, anio);

  // Agentes
  Future<Either<Failure, ClienteModel>> buscarClienteByTipoDocAndDoc(
          String tipoDoc, String doc) =>
      _api.buscarClienteByTipoDocAndDoc(tipoDoc, doc);

  Future<Either<Failure, AgenteParametroModel>> obtenerParametrosAgente() =>
      _api.obtenerParametrosAgente();

  Future<Either<Failure, List<DestinoSolicitudAgenteModel>>>
      obtenerDestinosAgente() => _api.obtenerDestinosAgente();

  Future<Either<Failure, bool>> subirArchivosAgente(
          Uint8List bytes, String filePath, int idsolicitud, String tipo) =>
      _api.subirArchivosAgente(bytes, filePath, idsolicitud, tipo);

  Future<Either<Failure, int>> enviarSolicitudAgente(
          SolicitudAgenteModel solicitud) =>
      _api.enviarSolicitudAgente(solicitud);

  Future<Either<Failure, List<SolicitudAgenteModel>>> obtenerReporteAgente(
          int mes, int anio) =>
      _api.obtenerReporteAgente(mes, anio);

  Future<Either<Failure, List<SolicitudAgenteModel>>>
      solicitudesPendientesAgente() => _api.solicitudesPendientesAgente();

  Future<Either<Failure, List<SolicitudAgenteModel>>>
      solicitudesAprobadosAgente() => _api.solicitudesAprobadosAgente();

  Future<Either<Failure, List<SolicitudAgenteModel>>>
      solicitudesRechazadosAgente() => _api.solicitudesRechazadosAgente();

  // seguros

  Future<Either<Failure, PersonaModel>> buscarPersonaByTipoDocAndDoc(
          String tipoDoc, String doc) =>
      _api.buscarPersonaByTipoDocAndDoc(tipoDoc, doc);

  Future<Either<Failure, bool>> subirArchivosSeguros(Uint8List bytes,
          String filePath, int idsolicitud, String tipo, String campo) =>
      _api.subirArchivosSeguros(bytes, filePath, idsolicitud, tipo, campo);

  Future<Either<Failure, int>> enviarSolicitudSeguros(
          SolicitudSeguroModel solicitud) =>
      _api.enviarSolicitudSeguros(solicitud);

  Future<Either<Failure, List<SolicitudSeguroModel>>> obtenerReporteSeguros(
          int mes, int anio) =>
      _api.obtenerReporteSeguros(mes, anio);

  Future<Either<Failure, List<SolicitudSeguroModel>>>
      solicitudesPendientesSeguros() => _api.solicitudesPendientesSeguros();

  Future<Either<Failure, List<SolicitudSeguroModel>>>
      solicitudesAprobadosSeguros() => _api.solicitudesAprobadosSeguros();

  Future<Either<Failure, List<SolicitudSeguroModel>>>
      solicitudesRechazadosSeguros() => _api.solicitudesRechazadosSeguros();

  Future<Either<Failure, SolicitudSeguroModel>> obtenerSolicitudSeguroById(
          int id) =>
      _api.obtenerSolicitudSeguroById(id);

  Future<Either<Failure, String>> confirmarSolicitudSeguro(int id) =>
      _api.confirmarSolicitudSeguro(id);
}
