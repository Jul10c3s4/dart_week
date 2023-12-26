import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer_app/app/repositories/auth/auth_repository.dart';
import 'package:vakinha_burguer_app/app/repositories/auth/auth_repository_impl.dart';

//widget criado para adicionar coisas para todo o app ter acesso
class AplicationBinding extends StatelessWidget {
  final Widget child;
  const AplicationBinding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      //Dessa maneira o custom dio vai poder ser acessado em qualquer lugar do app
      Provider(create: (context) => CustomDio()),
      //o context.read() serve para que o objeto pegue o seu parâmetro dentro da classe que está sendo instanciada, 
      
      //obs: caso o objeto criado no create necessite de algum parâmetro que será passado por meio do context.read(), é necessário antes especificar qual o tipo do parâmetro ao criar o Provider
      Provider<AuthRepository>(
        create: (context) => AuthRepositoryImpl(dio: context.read()),)
    ],
    
    child: child,);
  }
}
