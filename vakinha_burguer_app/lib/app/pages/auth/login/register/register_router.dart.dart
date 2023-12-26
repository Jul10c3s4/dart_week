import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/register/register_controller.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/register/register_page.dart';

class RegisterRouterDart {
  RegisterRouterDart._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => RegisterController(
              context.read(),
            ),
          )
        ],
        child: const RegisterPage(),
      );
}
