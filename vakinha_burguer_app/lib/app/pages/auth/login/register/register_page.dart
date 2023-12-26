import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_app_bar.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_button.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/register/register_controller.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/register/register_state.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/base_state/base_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void dispose() {
    //é necessário elimina-los não acontecer um vazamento de memória na aplicação
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.pop(context);
          },
          error: () {
            hideLoader();
            showError('Erro ao cadastrar usuário');
          },
        );
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Cadastro',
                      style: context.textStyles.textTitle,
                    ),
                    Text(
                      'Preencha os campos abaixo para criar o seu cadastro.',
                      style:
                          context.textStyles.textMedium.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _nameEC,
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: Validatorless.required('Nome obrigatório'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _emailEC,
                      decoration: InputDecoration(labelText: 'E-mail'),
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail obrigatório'),
                        Validatorless.email('E-mail inválido')
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordEC,
                      decoration: InputDecoration(labelText: 'Senha'),
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatório'),
                        Validatorless.min(
                            6, 'A senha deve conter pelo menos 6 caracteres')
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Confirmar senha'),
                      validator: Validatorless.multiple([
                        Validatorless.required(
                            'confirmação de senha obrigatório'),
                        Validatorless.compare(
                            _passwordEC, "Senha diferente de confirmar senha")
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    DeliveryButton(
                      onPressed: () {
                        final validacao =
                            _formKey.currentState?.validate() ?? false;
                        if (validacao) {
                          controller.register(
                              _nameEC.text, _emailEC.text, _passwordEC.text);
                        }
                      },
                      label: 'Cadastrar',
                      heigth: context.percentheight(.018),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
