import 'package:usando_bloc/models/endereco_model.dart';

//Aqui  está a classe que vai fazer a gerencia de estados da tela de homepage, nela, cada class representa um novo estado que irá mudar na tela
abstract class HomeState {}

//estado inicial
class HomeInitial extends HomeState {}

//quando o loading estiver carregando
class HomeLoading extends HomeState {}

//quando houver algum erro, normalmente é usado no try catch
class HomeFailure extends HomeState {}

//quando o loading estiver carregado
class HomeLoaded extends HomeState {
  final EnderecoModel enderecomodel;

  HomeLoaded({required this.enderecomodel});
}
