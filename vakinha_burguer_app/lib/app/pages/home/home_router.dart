import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer_app/app/pages/home/home_controller.dart';
import 'package:vakinha_burguer_app/app/pages/home/home_page.dart';
import 'package:vakinha_burguer_app/app/repositories/products/products_repositories.dart';
import 'package:vakinha_burguer_app/app/repositories/products/products_repositoriesimpl.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
    providers: [
      Provider<ProductsRepositories>(create: (context) => ProductsRepositoriesimpl(
        //Ele pega o customDio lá do aplication binding, onde foi injetado no provider geral do app, e injeta na homePage 
        dio: context.read<CustomDio>())
        ),
        Provider(create: (context)=> HomeController(context.read()))
    ], 
    child: HomePage(),
  );
}