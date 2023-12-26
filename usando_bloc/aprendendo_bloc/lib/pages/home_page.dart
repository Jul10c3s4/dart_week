import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usando_bloc/models/endereco_model.dart';
import 'package:usando_bloc/pages/state_subclass/home_controler.dart';
import 'package:usando_bloc/pages/state_subclass/home_state.dart';
import 'package:usando_bloc/repositories/cep_repository.dart';
import 'package:usando_bloc/repositories/cep_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = HomeController();
  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: homeController,
      listener: (context, state) {
        if (state is HomeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Erro ao busca Endereço!'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Buscador de CEP',
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
                        homeController.findCep(cepEC.text);
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
                  
                      BlocBuilder<HomeController, HomeState>(
                        bloc: homeController,
                          builder: (context, state) {
                        return Visibility(
                            visible: state is HomeLoading,
                            child: Center(
                              child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                            ) );
                      }),
                      BlocBuilder<HomeController, HomeState>(
                        bloc: homeController,
                          builder: ((context, state) {
                        if (state is HomeLoaded) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Estado: ${state.enderecomodel.uf}'),
                                Text(
                                    'Cidade: ${state.enderecomodel.localidade}'),
                                Text('Bairro: ${state.enderecomodel.bairro}'),
                                Text(
                                    'Logradouro: ${state.enderecomodel.logra}'),
                                Text(
                                    'Complemeto: ${state.enderecomodel.comple}'),
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
