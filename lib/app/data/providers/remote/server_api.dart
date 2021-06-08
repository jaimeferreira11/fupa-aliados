import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fupa_aliados/app/config/constants.dart';
import 'package:fupa_aliados/app/config/dio_config.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/respuesta_model.dart';
import 'package:fupa_aliados/app/data/models/token_model.dart';
import 'package:fupa_aliados/app/data/models/usuario_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart' show required;

class ServerAPI {
  final DioService _dio = Get.find<DioService>();

  Future<Either<Failure, TokenModel>> login(
      String username, String password) async {
    final url = AppConstants.API_URL + 'oauth/token';
    final res = await _dio.client.post(url, queryParameters: {
      'username': username.trim(),
      'password': password.trim(),
      'grant_type': 'password'
    });

    if (res.statusCode == 200) {
      final data = TokenModel.fromJson(res.data);

      Cache.instance.token = data.accessToken;

      return right(data);
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, UsuarioModel>> verificarSession() async {
    final url = AppConstants.API_URL + 'api/v1/oauth/check-token';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      final data = UsuarioModel.fromJson(res.data);

      Cache.instance.user = data;

      return right(data);
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, UsuarioModel>> obtenerUserInfo(String token) async {
    //final url = AppConstants.API_URL + 'private/user-info';
    final url = 'private/user-info';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      final data = RespuestaModel.fromJson(res.data);

      return right(UsuarioModel.fromJson(data.datos));
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, String>> cambiarPassword(
      String oldPwd, String newPwd) async {
    final url = AppConstants.API_URL + 'private/change-user-password';

    final res = await _dio.client.post(url, queryParameters: {
      'currentpassword': oldPwd,
      'newpassword': newPwd,
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      final respuesta = RespuestaModel.fromJson(res.data);
      if (respuesta.estado.toUpperCase() == 'OK') {
        return right(respuesta.datos);
      } else {
        return left(CacheFailure(mensaje: respuesta.error));
      }
    } else {
      return left(ServerFailure(mensaje: "Error interno. Intente mas tarde"));
    }
  }

  Future<Either<Failure, String>> recuperarClave(String correo) async {
    final url = AppConstants.API_URL + 'public/usuario/cambiar-clave"';

    final res =
        await _dio.client.post(url, queryParameters: {'correo': correo});
    if (res.statusCode == 200) {
      return right(res.data['datos']);
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, String>> actualizarUsuario(UsuarioModel user) async {
    final url = AppConstants.API_URL + 'private/update-user-aliado';

    final res = await _dio.client.post(url,
        queryParameters: {"celular": user.phonenumber, "correo": user.email});
    if (res.statusCode == 200) {
      return right(res.data['datos']);
    } else {
      return left(ServerFailure());
    }
  }

  Future<void> logout() async {
    final url = AppConstants.API_URL + 'oauth/revoke-token';

    await _dio.client.post(url);
    // await _localAuth.();
  }
}
