import 'package:match/match.dart';
import 'package:usando_bloc/models/endereco_model.dart';

part 'home_state.g.dart';

@match
enum HomeStatus { initial, loading, loaded, failure }

class HomeState {
  final EnderecoModel? enderecoModel;
  final HomeStatus status;

  HomeState({
    this.enderecoModel,
    this.status = HomeStatus.initial,
  });

  HomeState copyWith({
    EnderecoModel? enderecoModel,
    HomeStatus? status,
  }) {
    return HomeState(
      enderecoModel: enderecoModel ?? this.enderecoModel,
      status: status ?? this.status,
    );
  }
}
