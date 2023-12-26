import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vakinha_burguer_app/app/core/extentions/formatter_extention.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/colors_app.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/dto/order_product_dto.dart';
import 'package:vakinha_burguer_app/app/models/product_model.dart';
import 'package:vakinha_burguer_app/app/pages/home/home_controller.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? orderProductDto;
  
  const DeliveryProductTile({
    Key? key,
    required this.product,
    required this.orderProductDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //como a classe é stateless é necessário pegar o conteúdo do context antes de mexer nele
        final controller = context.read<HomeController>();
        final orderProductResult = await Navigator.of(context).pushNamed(
            '/productDetail',
            // A pagina ProductDetail precisa do parametro  product, então ela é passada pela propriedade arguments do pushNamed, por meio da declaração de um mapa, na qual poderá ser passado o objeto, para em seguida ser acessado onde se tem a criação desse objeto
            arguments: {'products': product, 'order': orderProductDto});
            
        if (orderProductResult != null) {
          controller.addOrUpdateBag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${product!.name.toString()}',
                      style: context.textStyles.textExtraBold
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${product!.description.toString()}',
                      style:
                          context.textStyles.textLight.copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${product!.price.currencyPTBR}',
                      style: context.textStyles.textLight.copyWith(
                          fontSize: 11, color: context.colors.secondary),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: product.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
