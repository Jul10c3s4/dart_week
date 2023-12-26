import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usando_bloc/models/endereco_model.dart';
import 'package:usando_bloc/pages/state_sigle_class/home_single_controller.dart';
import 'package:usando_bloc/pages/state_sigle_class/home_state.dart';
import 'package:usando_bloc/repositories/cep_repository.dart';
import 'package:usando_bloc/repositories/cep_repository_impl.dart';

class HomeSinglePage extends StatefulWidget {
  const HomeSinglePage({super.key});

  @override
  State<HomeSinglePage> createState() => _HomeSinglePageState();
}

class _HomeSinglePageState extends State<HomeSinglePage> {
  final homeSingleClassController = HomeSingleClassController();
  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeSingleClassController, HomeState>(
      bloc: homeSingleClassController,
      listener: (context, state) {
        //obriga à configurar todos os estados
        //state.status.match(initial: initial, loading: loading, loaded: loaded, failure: failure)
        state.status.matchAny(
            any: () {},
            failure: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Erro ao busca Endereço!'),
                backgroundColor: Colors.red,
              ));
            });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Buscador de CEP Com HomeSinglePage',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellowAccent,
        ),
        body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira algum valor!';
                      }
                      return null;
                    }),
                    controller: cepEC,
                    decoration: InputDecoration(
                        labelText: "Insira seu CEP:",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final valid = formKey.currentState?.validate() ?? false;
                      if (valid) {
                        homeSingleClassController.findCep(cepEC.text);
                      }
                    },
                    child: Text(
                      'Procurar CEP',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<HomeSingleClassController, HomeState>(
                      bloc: homeSingleClassController,
                      builder: (context, state) {
                        return Visibility(
                            visible: state.status == HomeStatus.loading,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            ));
                      }),
                  BlocBuilder<HomeSingleClassController, HomeState>(
                      bloc: homeSingleClassController,
                      builder: ((context, state) {
                        if (state.status == HomeStatus.loaded) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Estado: ${state.enderecoModel?.uf}'),
                                Text(
                                    'Cidade: ${state.enderecoModel?.localidade}'),
                                Text('Bairro: ${state.enderecoModel?.bairro}'),
                                Text(
                                    'Logradouro: ${state.enderecoModel?.logra}'),
                                Text(
                                    'Complemeto: ${state.enderecoModel?.comple}'),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }))
                ],
              ),
            )),
      ),
    );
  }
}
