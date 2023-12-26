import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vakinha_burguer_app/app/core/extentions/formatter_extention.dart';
import 'package:vakinha_burguer_app/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_app_bar.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_increment_decrement_button.dart';
import 'package:vakinha_burguer_app/app/dto/order_product_dto.dart';
import 'package:vakinha_burguer_app/app/models/product_model.dart';
import 'package:vakinha_burguer_app/app/pages/product_detail/product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;

  const ProductDetailPage({
    Key? key,
    required this.product,
    this.order,
  }) : super(key: key);
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void initState() {
    super.initState();
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentheight(.4),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.product.image.toString(),
                    ))),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Text(
                  widget.product.description,
                  style: context.textStyles.textLight.copyWith(fontSize: 18),
                ),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 68,
                width: context.percentWidth(.4),
                padding: EdgeInsets.all(8),
                child: BlocBuilder<ProductDetailController, int>(
                    builder: (context, amount) {
                  return DeliveryIncrementDecrementButton(
                    decrement: controller.decrement,
                    increment: controller.increment,
                    amount: amount,
                  );
                }),
              ),
              Container(
                width: context.percentWidth(.6),
                height: 68,
                padding: const EdgeInsets.all(8),
                //é o cara que rebiuda a tela quando necessário
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, amount) {
                    return ElevatedButton(
                        style: amount == 0
                            ? ElevatedButton.styleFrom(
                                backgroundColor: Colors.red)
                            : null,
                        onPressed: () {
                          if (amount == 0) {
                            _showConfirmDelete(amount);
                          } else {
                            Navigator.of(context).pop(OrderProductDto(
                                product: widget.product, amount: amount));
                          }
                        },
                        child: Visibility(
                          visible: amount > 0,
                          replacement: Text(
                            'Excluir Produto',
                            style: context.textStyles.textExtraBold
                                .copyWith(fontSize: 13),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  "Adicionar",
                                  maxFontSize: 13,
                                  minFontSize: 5,
                                  maxLines: 1,
                                  style: context.textStyles.textExtraBold
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  (widget.product.price * amount).currencyPTBR,
                                  maxFontSize: 13,
                                  minFontSize: 5,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: context.textStyles.textExtraBold,
                                ),
                              )
                            ],
                          ),
                        ));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showConfirmDelete(int amount) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Deseja excluir o produto ?'),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
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
                    Navigator.of(context).pop(OrderProductDto(
                                product: widget.product, amount: amount));
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
}
