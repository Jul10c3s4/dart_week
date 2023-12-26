import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_burguer_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:vakinha_burguer_app/app/repositories/auth/auth_repository.dart';

import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  AuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', authModel.accessToken.toString());
      sp.setString('refreshToken', authModel.refreshToken.toString());
      print(authModel.accessToken.toString());
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (e, s) {
      log('Login e senha inválidos', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.loginError,
          errorMessege: ' Login e senha inválidos'));
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.error, errorMessege: 'Erro ao realizar login'));
    }
  }
}
