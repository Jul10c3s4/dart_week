import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer_app/app/dto/order_product_dto.dart';
import 'dart:developer';
import 'package:vakinha_burguer_app/app/pages/home/home_state.dart';
import 'package:vakinha_burguer_app/app/repositories/products/products_repositories.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepositories _productsRepositories;

  HomeController(
    this._productsRepositories,
    //estado inicial da tela
  ) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      //essa função coloca os produtos na tela
      final products = await _productsRepositories.findAllProducts();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: HomeStateStatus.error,
            errorMessage: 'Erro buscar produtos'),
      );
    }
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];
    final orderIndex = shoppingBag
        .indexWhere((orderP) => orderP.product == orderProduct.product);

    if (orderIndex > -1) {
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {
        shoppingBag[orderIndex] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }

    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updateBag(List<OrderProductDto>? updateBag) {
    emit(state.copyWith(shoppingBag: updateBag));
  }
}
