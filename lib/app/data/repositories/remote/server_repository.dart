import 'package:dartz/dartz.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
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
}
