import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer_app/app/pages/order/order_page.dart';
import 'package:vakinha_burguer_app/app/repositories/order/order_repository.dart';
import 'package:vakinha_burguer_app/app/repositories/order/order_repository_impl.dart';

import 'order_controller.dart';

class OrderRouter {
  OrderRouter._();
  static Widget get page => MultiProvider(providers: [
        Provider<OrderRepository>(create: (context) => OrderRepositoryImpl(dio: context.read())),
        Provider(
          create: (context) => OrderController(context.read()),
        ),
      ],
      child: const OrderPage(),);
}
