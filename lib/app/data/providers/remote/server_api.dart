import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:fupa_aliados/app/config/constants.dart';
import 'package:fupa_aliados/app/config/dio_config.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/agente_parametro_model.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/destino_solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/persona_model.dart';
import 'package:fupa_aliados/app/data/models/proforma_model.dart';
import 'package:fupa_aliados/app/data/models/respuesta_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_seguro_model.dart';
import 'package:fupa_aliados/app/data/models/token_model.dart';
import 'package:fupa_aliados/app/data/models/usuario_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';

import 'package:get/get.dart';

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

  Future<Either<Failure, ClienteModel>> verificarDisponibilidadCliente(
      String tipoDoc, String doc) async {
    //final url = AppConstants.API_URL + 'private/user-info';
    final url = 'private/franquicia/disponibilidad-cliente/$doc/$tipoDoc';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      print(res.data);
      final data = RespuestaModel.fromJson(res.data);

      if (data.estado.toUpperCase() == 'OK') {
        return right(ClienteModel.fromJson(data.datos));
      } else {
        return left(NoDataFailure(mensaje: data.error));
      }
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, String>> solicitarCodigoVerificacion(
      {int idpersona, String cel, String monto, String plazo}) async {
    //final url = AppConstants.API_URL + 'private/user-info';
    final url =
        'private/franquicia/solicitar-codigo/$idpersona/$cel/$monto/$plazo';

    final res = await _dio.client.get(url);
    print(res.statusCode);
    if (res.statusCode == 200) {
      return right(res.data['datos']);
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, String>> enviarSolicitud(
      String codigo, ProformaModel proforma) async {
    print(proforma.toJson());

    try {
      final url = AppConstants.API_URL +
          'private/franquicia/enviar-solicitud/$codigo?json=${jsonEncode(proforma)}';

      final res = await _dio.client
          .post(url, queryParameters: {"json": proforma.toJson()});
      if (res.statusCode == 200) {
        print(res);
        if (res.data['estado'].toUpperCase() == 'OK') {
          return right(res.data['datos']);
        } else {
          return left(CustomFailure(mensaje: res.data['error']));
        }
      } else {
        return left(ServerFailure(mensaje: res.data['error']));
      }
    } catch (e) {
      print(e);
      return left(ServerFailure(mensaje: 'Erro interno'));
    }
  }

  Future<Either<Failure, bool>> reenviarCodigo(
      String numero, String mensaje) async {
    final url = AppConstants.API_URL + 'private/reenviar-sms';

    final res = await _dio.client.post(url, queryParameters: {
      'numero': numero,
      'mensaje': mensaje,
    });
    if (res.statusCode == 200) {
      return right(true);
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, List<ProformaModel>>> obtenerSolicitudes(
      int mes, int anio) async {
    final url = AppConstants.API_URL + 'private/franquicia/$mes/$anio';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(ProformaModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, String>> sendMail(
      String asunto, String mensaje) async {
    final url = AppConstants.API_URL + 'public/send-mail';

    final res = await _dio.client.post(url, queryParameters: {
      "destinatario": AppConstants.EMAIL_ADMIN,
      "mensaje": mensaje,
      "asunto": asunto
    });
    if (res.statusCode == 200) {
      return right(res.data['datos']);
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, int>> getVersion() async {
    String app = "APP_ALIADOS_ANDROID";
    if (Platform.isIOS) app = "APP_ALIADOS_IOS";

    final url = AppConstants.API_URL + 'public/v2/version-app/$app';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(res.data['datos']);
    }
    return left(ServerFailure());
  }

  // Agentes
  Future<Either<Failure, ClienteModel>> buscarClienteByTipoDocAndDoc(
      String tipoDoc, String doc) async {
    final url = 'private/cliente/byDoc/$doc/$tipoDoc';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      print(res.data);
      final data = RespuestaModel.fromJson(res.data);

      if (data.estado.toUpperCase() == 'OK') {
        return right(ClienteModel.fromJson(data.datos));
      } else {
        return left(NoDataFailure(mensaje: data.error));
      }
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, AgenteParametroModel>>
      obtenerParametrosAgente() async {
    final url = 'private/agente/parametros';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      final data = RespuestaModel.fromJson(res.data);

      if (data.estado.toUpperCase() == 'OK') {
        print(data.datos);
        return right(AgenteParametroModel.fromMap(data.datos));
      } else {
        return left(NoDataFailure(mensaje: data.error));
      }
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, List<DestinoSolicitudAgenteModel>>>
      obtenerDestinosAgente() async {
    final url = 'private/agente/destinos';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      final data = RespuestaModel.fromJson(res.data);

      if (data.estado.toUpperCase() == 'OK') {
        print(data.datos);
        return right(DestinoSolicitudAgenteModel.fromJsonList(data.datos));
      } else {
        return left(NoDataFailure(mensaje: data.error));
      }
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> subirArchivosAgente(
      Uint8List bytes, String filePath, int idsolicitud, String tipo) async {
    final url = AppConstants.API_URL + 'private/agente/v2/subir-archivo';

    dio.FormData formData = dio.FormData.fromMap({
      'file': dio.MultipartFile.fromBytes(bytes, filename: basename(filePath)),
      'idsolicitud': idsolicitud,
      'tipo': tipo
    });

    final res = await _dio.client.post(url, data: formData);
    if (res.statusCode == 200) {
      return right(true);
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, int>> enviarSolicitudAgente(
      SolicitudAgenteModel solicitud) async {
    try {
      final url = AppConstants.API_URL + 'private/agente/enviar-solicitud';

      final res = await _dio.client.post(url, data: solicitud.toMap());
      if (res.statusCode == 200) {
        print(res);
        if (res.data['estado'].toUpperCase() == 'OK') {
          return right(res.data['datos']);
        } else {
          return left(CustomFailure(mensaje: res.data['error']));
        }
      } else {
        return left(ServerFailure(mensaje: res.data['error']));
      }
    } catch (e) {
      print(e);
      return left(ServerFailure(mensaje: 'Erro interno'));
    }
  }

  Future<Either<Failure, List<SolicitudAgenteModel>>> obtenerReporteAgente(
      int mes, int anio) async {
    final url = AppConstants.API_URL + 'private/agente/confirmados/$mes/$anio';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudAgenteModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, List<SolicitudAgenteModel>>>
      solicitudesPendientesAgente() async {
    final url = 'private/agente/solicitudes/pendientes';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudAgenteModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, List<SolicitudAgenteModel>>>
      solicitudesAprobadosAgente() async {
    final url = 'private/agente/solicitudes/aprobados';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudAgenteModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, List<SolicitudAgenteModel>>>
      solicitudesRechazadosAgente() async {
    final url = 'private/agente/solicitudes/rechazados';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudAgenteModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  // Seguros
  Future<Either<Failure, bool>> subirArchivosSeguros(Uint8List bytes,
      String filePath, int idsolicitud, String tipo, String campo) async {
    final url = AppConstants.API_URL + 'private/agente-seguros/subir-archivo';

    dio.FormData formData = dio.FormData.fromMap({
      'file': dio.MultipartFile.fromBytes(bytes, filename: basename(filePath)),
      'idsolicitud': idsolicitud,
      'campo': campo,
      'tipo': tipo
    });

    final res = await _dio.client.post(url, data: formData);
    if (res.statusCode == 200) {
      return right(true);
    } else {
      return left(ServerFailure());
    }
  }

  Future<Either<Failure, int>> enviarSolicitudSeguros(
      SolicitudSeguroModel solicitud) async {
    try {
      final url =
          AppConstants.API_URL + 'private/agente-seguros/enviar-solicitud';

      final res = await _dio.client.post(url, data: solicitud.toMap());
      if (res.statusCode == 200) {
        print(res);
        if (res.data['estado'].toUpperCase() == 'OK') {
          return right(res.data['datos']);
        } else {
          return left(CustomFailure(mensaje: res.data['error']));
        }
      } else {
        return left(ServerFailure(mensaje: res.data['error']));
      }
    } catch (e) {
      print(e);
      return left(ServerFailure(mensaje: 'Erro interno'));
    }
  }

  Future<Either<Failure, List<SolicitudSeguroModel>>> obtenerReporteSeguros(
      int mes, int anio) async {
    final url =
        AppConstants.API_URL + 'private/agente-seguros/confirmados/$mes/$anio';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudSeguroModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, List<SolicitudSeguroModel>>>
      solicitudesPendientesSeguros() async {
    final url = 'private/agente-seguros/solicitudes/pendientes';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudSeguroModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, List<SolicitudSeguroModel>>>
      solicitudesAprobadosSeguros() async {
    final url = 'private/agente-seguros/solicitudes/aprobados';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudSeguroModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, List<SolicitudSeguroModel>>>
      solicitudesRechazadosSeguros() async {
    final url = 'private/agente-seguros/solicitudes/rechazados';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudSeguroModel.fromJsonList(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, SolicitudSeguroModel>> obtenerSolicitudSeguroById(
      int id) async {
    final url = 'private/agente-seguros/solicitudes/$id';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      return right(SolicitudSeguroModel.fromMap(res.data['datos']));
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, String>> confirmarSolicitudSeguro(int id) async {
    final url = 'private/agente-seguros/confirmar/$id';

    final res = await _dio.client.post(url);
    if (res.statusCode == 200) {
      return right(res.data['datos']);
    }
    return left(ServerFailure());
  }

  Future<Either<Failure, PersonaModel>> buscarPersonaByTipoDocAndDoc(
      String tipoDoc, String doc) async {
    final url = 'private/persona/byDoc/$doc/$tipoDoc';

    final res = await _dio.client.get(url);
    if (res.statusCode == 200) {
      print(res.data);
      final data = RespuestaModel.fromJson(res.data);

      if (data.estado.toUpperCase() == 'OK') {
        return right(PersonaModel.fromJson(data.datos));
      } else {
        return left(NoDataFailure(mensaje: data.error));
      }
    } else {
      return left(ServerFailure());
    }
  }
}
