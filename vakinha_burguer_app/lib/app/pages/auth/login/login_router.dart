import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/login_controller.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/login_page.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiBlocProvider(providers: [
        Provider<LoginController>(
            create: (context) => LoginController(context.read())),
      ], child: const LoginPage());
}
