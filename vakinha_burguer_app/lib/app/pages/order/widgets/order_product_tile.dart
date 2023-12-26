import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer_app/app/core/extentions/formatter_extention.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/colors_app.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_increment_decrement_button.dart';

import 'package:vakinha_burguer_app/app/dto/order_product_dto.dart';
import 'package:vakinha_burguer_app/app/pages/order/order_controller.dart';

class OrderProductTile extends StatefulWidget {
  final int index;
  final OrderProductDto orderProductDto;

  const OrderProductTile({
    super.key,
    required this.index,
    required this.orderProductDto,
  });

  @override
  State<OrderProductTile> createState() => _OrderProductTileState();
}

class _OrderProductTileState extends State<OrderProductTile> {
  @override
  Widget build(BuildContext context) {
    final product = widget.orderProductDto.product;
    return Row(
      children: [
        Image.network(
          product.image.toString(),
          width: 100,
          height: 100,
          fit: BoxFit.scaleDown,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: context.textStyles.textRegular.copyWith(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (widget.orderProductDto.amount * product.price)
                          .currencyPTBR,
                      style: context.textStyles.textMedium.copyWith(
                          fontSize: 14, color: context.colors.secondary),
                    ),
                    Container(
                      width: context.percentWidth(.2),
                      height: context.percentheight(.04),
                      child: DeliveryIncrementDecrementButton.compact(
                          amount: widget.orderProductDto.amount,
                          increment: () {
                            context
                                .read<OrderController>()
                                .incrementProduct(widget.index);
                          },
                          decrement: () {
                            context.read<OrderController>().decrementProduct(widget.index);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
