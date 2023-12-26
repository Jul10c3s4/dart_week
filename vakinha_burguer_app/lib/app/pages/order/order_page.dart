
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_burguer_app/app/core/extentions/formatter_extention.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_app_bar.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_button.dart';
import 'package:vakinha_burguer_app/app/dto/order_product_dto.dart';
import 'package:vakinha_burguer_app/app/models/payment_Type_model.dart';
import 'package:vakinha_burguer_app/app/models/product_model.dart';
import 'package:vakinha_burguer_app/app/pages/order/order_controller.dart';
import 'package:vakinha_burguer_app/app/pages/order/order_state.dart';
import 'package:vakinha_burguer_app/app/pages/order/widgets/order_field.dart';
import 'package:vakinha_burguer_app/app/pages/order/widgets/order_product_tile.dart';
import 'package:vakinha_burguer_app/app/pages/order/widgets/payment_types_field.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/base_state/base_state.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final adressEC = TextEditingController();
  final cpfEC = TextEditingController();
  int? paymentTypeId;
  //usado para que a tela atualize somente um widget
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    final produtos =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(produtos);
    print(controller.state.orderProducts.length);
  }

  void _showConfirmEmptyBag() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Realmente deseja excluir todos os produtos ?'),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.cancelDeleteProcess();
                  },
                  child: Text(
                    'Cancelar',
                    style: context.textStyles.textBold
                        .copyWith(color: Colors.white),
                  )),
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                    showInfo(
                        'Sua sacola está vazia selecione um produto para realizar seu pedido');
                    Navigator.pop(context, <OrderProductDto>[]);
                  },
                  child: Text(
                    'Confirmar',
                    style: context.textStyles.textBold
                        .copyWith(color: Colors.white),
                  ))
            ],
          );
        });
  }

  void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Deseja excluir o produto ${state.orderProduct.product.name}?'),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.cancelDeleteProcess();
                  },
                  child: Text(
                    'Cancelar',
                    style: context.textStyles.textBold
                        .copyWith(color: Colors.white),
                  )),
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                    controller.decrementProduct(state.index);
                  },
                  child: Text(
                    'Confirmar',
                    style: context.textStyles.textBold
                        .copyWith(color: Colors.white),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          loaded: () => hideLoader(),
          confirmRemoveProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmProductDialog(state);
            }
          },
          emptyBag: () {
            _showConfirmEmptyBag();
          },
          error: () {
            hideLoader();
            showError(state.errorMessege.toString());
          },
          success: () {
            hideLoader();
            Navigator.of(context).popAndPushNamed('/order/completed', result: <OrderProductDto>[]);
          },
        );
      },
      //esse widget tem a função de realizar alguma ação após o scaffold ser fechado, no exemplo abaixo após a tela ser fechada ela atualizará o estado da tela que está abaixo dela de modo a prover um novo orderProducts.
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
            appBar: DeliveryAppBar(),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Carrinho',
                          style: context.textStyles.textTitle,
                        ),
                        IconButton(
                            icon: Image.asset('assets/images/trashRegular.png'),
                            onPressed: () => controller.emptyBag())
                      ],
                    ),
                  ),
                ),
                //o blocSelector extrai uma parte do estado grandão e pega um item de dentro, fazendo com que só seja atualizado o necessário
                BlocSelector<OrderController, OrderState,
                    List<OrderProductDto>>(
                  selector: (state) => state.orderProducts,
                  builder: (context, orderProducts) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: orderProducts.length, (context, index) {
                        final orderProduct = orderProducts[index];
                        return Column(
                          children: [
                            OrderProductTile(
                                index: index, orderProductDto: orderProduct),
                            const Divider(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      }),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total de pedidos',
                              style: context.textStyles.textExtraBold
                                  .copyWith(fontSize: 16),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                                selector: (state) => state.totalOrder,
                                builder: (context, totalOrder) {
                                  return Text(
                                    totalOrder.currencyPTBR,
                                    style: context.textStyles.textExtraBold
                                        .copyWith(fontSize: 20),
                                  );
                                }),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            OrderField(
                                title: 'Endereço de entrega',
                                controller: adressEC,
                                validator: Validatorless.required(
                                    'Campo endereço obrigatório'),
                                hintText: 'Digite seu endereço'),
                            const SizedBox(
                              height: 10,
                            ),
                            OrderField(
                                title: 'CPF',
                                controller: cpfEC,
                                validator: Validatorless.required(
                                    'Campo cpf obrigatório'),
                                hintText: 'Digite o CPF'),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      BlocSelector<OrderController, OrderState,
                              List<PaymentTypeModel>>(
                          selector: (state) => state.paymentTypes,
                          builder: (context, paymentTypes) {
                            //observa quando o widget deve ser atualizado
                            return ValueListenableBuilder(
                              valueListenable: paymentTypeValid,
                              builder: (_, paymentTypeValidValue, child) {
                                return PaymentTypesField(
                                  paymentTypes: paymentTypes,
                                  valueChanged: (value) {
                                    paymentTypeId = value;
                                  },
                                  valid: paymentTypeValidValue,
                                  valueSelected: paymentTypeId.toString(),
                                );
                                ;
                              },
                            );
                          }),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: DeliveryButton(
                            heigth: context.percentheight(.02),
                            label: 'FINALIZAR',
                            onPressed: () async {
                              print(controller.state.status);
                              final valid =
                                  formKey.currentState!.validate() ?? false;
                              final paymentTypeSelected = paymentTypeId != null;
                              paymentTypeValid.value = paymentTypeSelected;
                              if (valid && paymentTypeSelected) {
                                controller.saveOrder(
                                    address: adressEC.text,
                                    document: cpfEC.text,
                                    paymentMethodId: paymentTypeId!);
                              }
                            }),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
