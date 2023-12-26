import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer_app/app/core/global/global_context.dart';
import 'package:vakinha_burguer_app/app/core/provider/aplication_binding.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/theme/theme_config.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/login_page.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/login_router.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/register/register_page.dart';
import 'package:vakinha_burguer_app/app/pages/auth/login/register/register_router.dart.dart';
import 'package:vakinha_burguer_app/app/pages/home/home_page.dart';
import 'package:vakinha_burguer_app/app/pages/home/home_router.dart';
import 'package:vakinha_burguer_app/app/pages/order/order_completed_page.dart';
import 'package:vakinha_burguer_app/app/pages/order/order_page.dart';
import 'package:vakinha_burguer_app/app/pages/order/order_router.dart';
import 'package:vakinha_burguer_app/app/pages/product_detail/product_detail_router.dart';
import 'package:vakinha_burguer_app/app/pages/splash/splash_page.dart';

class DeliveryApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  DeliveryApp({super.key}){
    GlobalContext.i.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return AplicationBinding(
        child: MaterialApp(
              navigatorKey: _navKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeConfig.theme,
            title: 'Delivery App',
            routes: {
          '/': (context) => SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouterDart.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletedPage(),
        }));
  }
}
