import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fupa_aliados/app/config/errors/exceptions.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/token_model.dart';
import 'package:fupa_aliados/app/data/models/usuario_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';

const CACHED_TOKEN = "CACHED_TOKEN";
const CACHED_USER = "CACHED_USER";

class AuthRepository {
  final _storage = new FlutterSecureStorage();

  Future<Either<Failure, bool>> deleteAuthToken() async {
    try {
      await _storage.deleteAll();
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, TokenModel>> getAuthToken() async {
    try {
      final jsonString = await _storage.read(key: CACHED_TOKEN);
      if (jsonString == null) throw CacheException();
      TokenModel result = TokenModel.fromJson(json.decode(jsonString));
      Cache.instance.token = result.accessToken;
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, TokenModel>> setAuthToken(TokenModel model) async {
    try {
      await _storage.write(
          key: CACHED_TOKEN, value: json.encode(model.toJson()));

      Cache.instance.token = model.accessToken;
      return Right(model);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, UsuarioModel>> getUsuario() async {
    try {
      final jsonString = await _storage.read(key: CACHED_USER);
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
      await _storage.write(key: CACHED_USER, value: value);
      return Right(model);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, bool>> deleteUsuario() async {
    try {
      await _storage.delete(key: CACHED_USER);
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
