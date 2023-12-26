import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usando_bloc/pages/state_subclass/home_state.dart';
import 'package:usando_bloc/repositories/cep_repository.dart';
import 'package:usando_bloc/repositories/cep_repository_impl.dart';

//Essa classe é criada para controlar os estados da tela, sendo que quando se quer que ocorra alguma mudança na tela é necessário emit um novo estado para a tela ser atualizada
class HomeController extends Cubit<HomeState> {
  final CepRepository cepRepository = CepRepositoryImpl();

  HomeController() : super(HomeInitial());

  Future<void> findCep(String cep) async {
    try {
      //vai ser emitido um novo estado na qual mudará o estado para loading
      emit(HomeLoading());
      final enderecoModel = await cepRepository.getCep(cep);
      emit(HomeLoaded(enderecomodel: enderecoModel));
    } catch (erro) {
      emit(HomeFailure());
    }
  }
}
