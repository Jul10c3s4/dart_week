import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer_app/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_app_bar.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_button.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/login_controller.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/login_state.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            login: () => showLoader(),
            loginError: () {
              hideLoader();
              showError("E-mail ou senha inválidos");
            },
            error: () {
              hideLoader();
              showError('Erro ao realizar login');
            },
            success: () {
              hideLoader();
              Navigator.pop(context, true);
            });
        
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Login',
                          style: context.textStyles.textTitle,
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('E-mail obrigatório'),
                            Validatorless.email('E-mail inválido')
                          ]),
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: passwordEC,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                          ),
                          validator: Validatorless.multiple(
                              [Validatorless.required('Senha obrigatório')]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        DeliveryButton(
                          heigth: context.percentheight(.02),
                          label: 'ENTRAR',
                          onPressed: () {
                            final validacao =
                                formKey.currentState!.validate() ?? false;
                            if (validacao) {
                              controller.login(emailEC.text, passwordEC.text);
                            }
                          },
                        ),
                      ],
                    )),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Não possui uma conta',
                          style: context.textStyles.textBold),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/auth/register');
                          },
                          child: Text('Cadastre-se',
                              style: context.textStyles.textBold
                                  .copyWith(color: Colors.blue)))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
