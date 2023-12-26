import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match/match.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/loader.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/messages.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_app_bar.dart';
import 'package:vakinha_burguer_app/app/models/product_model.dart';
import 'package:vakinha_burguer_app/app/pages/home/home_controller.dart';
import 'package:vakinha_burguer_app/app/pages/home/home_state.dart';
import 'package:vakinha_burguer_app/app/pages/home/widgets/delivery_product_tile.dart';
import 'package:vakinha_burguer_app/app/pages/home/widgets/shopping_bag_widget.dart';

import '../../core/ui/base_state/base_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    //SharedPreferences.getInstance().then((value) => value.clear());
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DeliveryAppBar(),
        // o blocConsumer espera alguma alteração através da propriedade Listener para em seguida atualizar a tela por meio do retorno passado na propriedade builder
        //obs: pode usar o blocConsumer na tela toda pois ele é capaz de atualizar somente o necessário
        body: BlocConsumer<HomeController, HomeState>(
          listener: (context, state) {
            state.status.matchAny(
                any: () => hideLoader(),
                loading: () => showLoader(),
                error: () {
                  hideLoader();
                  showError(state.errorMessage ?? 'Erro não informado');
                });
          },
          buildWhen: ((previous, current) => current.status.matchAny(
                any: () => false,
                initial: () => true,
                loaded: () => true,
              )),
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      final orders = state.shoppingBag
                          .where((order) => order.product == product);

                      return DeliveryProductTile(
                        product: product,
                        orderProductDto:
                            orders.isNotEmpty ? orders.first : null,
                      );
                    },
                  ),
                ),
                Visibility(
                    visible: state.shoppingBag.isNotEmpty,
                    child: ShoppingBagWidget(bag: state.shoppingBag))
              ],
            );
          },
        ));
  }
}
