import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer_app/app/pages/product_detail/product_detail_controller.dart';
import 'package:vakinha_burguer_app/app/pages/product_detail/product_detail_page.dart';

class ProductDetailRouter {
  ProductDetailRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            //com isso o controler poderá ser usado na tela
            create: (context) => ProductDetailController(),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          return ProductDetailPage(
            // Esse args pegou o objeto ProductModel passado na propriedade arguments do pushNamed
            product: args['products'],
            order: args['order'],
          );
        },
      );
}
