import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:vakinha_burguer_app/app/dto/order_product_dto.dart';
import 'package:vakinha_burguer_app/app/models/product_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<ProductModel> products;
  final String? errorMessage;
  final List<OrderProductDto> shoppingBag;

  const HomeState({
    required this.status,
    required this.products,
    this.errorMessage,
    required this.shoppingBag,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const [],
        errorMessage = null,
        shoppingBag = const [];

  @override
  // TODO: implement props
  List<Object?> get props => [status, products, errorMessage, shoppingBag];

//função criada para alterar o estado da classe quando necessário
  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    List<OrderProductDto>? shoppingBag,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage, shoppingBag: shoppingBag ?? this.shoppingBag,
    );
  }
}
