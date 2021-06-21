import 'package:dartz/dartz.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/proforma_model.dart';
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

  Future<Either<Failure, String>> sendMail(String asunto, String mensaje) =>
      _api.sendMail(asunto, mensaje);

  Future<Either<Failure, int>> getVersion() => _api.getVersion();
}
