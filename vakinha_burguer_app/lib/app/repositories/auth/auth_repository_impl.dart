import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burguer_app/app/core/exceptions/repository_exceptions.dart';
import 'package:vakinha_burguer_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:vakinha_burguer_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer_app/app/models/auth_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({
    required this.dio,
  });
  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log("permissão negada", error: e, stackTrace: s);
        throw UnauthorizedException();
      }
      log('Erro ao realizar Login', error: e, stackTrace: s);
      throw RepositoryExceptions(message: 'Erro ao realizar Login');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryExceptions(message: 'erro ao registrar usuário');
    }
  }
}
