import 'dart:async';

import 'package:fupa_aliados/app/data/models/usuario_model.dart';
import 'package:logger/logger.dart';

class Cache {
  Cache._internal();
  static Cache _instance = Cache._internal();
  static Cache get instance => _instance;

  String token;
  UsuarioModel user;


  Completer _completer;

  final log = Logger();

  _complete() {
    if (this._completer != null && !this._completer.isCompleted) {
      this._completer.complete();
    }
  }

  Future<void> setToken(String data) async {
    print("Guardando el token en memoria");
    this.token = data;
    log.d("Token guardado en cache");
  }

  Future<void> setUsuario(UsuarioModel data) async {
    print("Guardando el usuario en memoria");
    this.user = data;
    print("usuario saved");
    //log.d("Usuario guardado en cache");
  }
}
