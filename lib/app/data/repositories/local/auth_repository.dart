import 'dart:convert';

import 'package:dartz/dartz.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fupa_aliados/app/config/errors/exceptions.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/token_model.dart';
import 'package:fupa_aliados/app/data/models/usuario_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_TOKEN = "CACHED_TOKEN";
const CACHED_USER = "CACHED_USER";

class AuthRepository {
  // final _storage = new FlutterSecureStorage();
  final SharedPreferences sharedPreferences;

  AuthRepository(this.sharedPreferences);

  Future<Either<Failure, bool>> deleteAuthToken() async {
    try {
      // await _storage.deleteAll();
      await sharedPreferences.clear();
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, TokenModel>> getAuthToken() async {
    try {
      // final jsonString = await _storage.read(key: CACHED_TOKEN);
      final jsonString = sharedPreferences.getString(CACHED_TOKEN);
      if (jsonString == null) throw CacheException();
      TokenModel result = TokenModel.fromJson(json.decode(jsonString));
      Cache.instance.token = result.accessToken;
      return Right(result);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, TokenModel>> setAuthToken(TokenModel model) async {
    try {
/*       await _storage.write(
          key: CACHED_TOKEN, value: json.encode(model.toJson())); */

      await sharedPreferences.setString(
          CACHED_TOKEN, json.encode(model.toJson()));

      Cache.instance.token = model.accessToken;
      return Right(model);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, UsuarioModel>> getUsuario() async {
    try {
      // final jsonString = await _storage.read(key: CACHED_USER);
      final jsonString = sharedPreferences.getString(CACHED_USER);
      if (jsonString == null) throw CacheException();

      return Right(UsuarioModel.fromJson(json.decode(jsonString)));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, UsuarioModel>> setUsuario(UsuarioModel model) async {
    try {
      Cache.instance.user = model;
      final String value = jsonEncode(model.toJson());
      //await _storage.write(key: CACHED_USER, value: value);
      await sharedPreferences.setString(CACHED_USER, value);
      return Right(model);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, bool>> deleteUsuario() async {
    try {
      // await _storage.delete(key: CACHED_USER);
      await sharedPreferences.remove(CACHED_USER);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
