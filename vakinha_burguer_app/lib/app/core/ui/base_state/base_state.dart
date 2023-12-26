import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/loader.dart';

import '../styles/helpers/messages.dart';

//é a classe que  ao ser extendida em outra serve para prover mixins de mensagem e loader e controllers 
abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, Messages {
  late final C controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    // o widget abaixo serve para alterar a tela somente depois dela ter sido montada
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  void onReady() {}
}
