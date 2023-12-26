import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burguer_app/app/core/exceptions/repository_exceptions.dart';
import 'package:vakinha_burguer_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer_app/app/models/product_model.dart';

import './products_repositories.dart';

class ProductsRepositoriesimpl implements ProductsRepositories {
  final CustomDio dio;

  ProductsRepositoriesimpl({required this.dio});

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await dio.unauth().get('/products');
      result.data
      .map((p) {
        print(p['price'].toString());
      }).toList();


      return result.data
      .map<ProductModel>(
        (p) => ProductModel.fromMap(p),
        )
        .toList();
    } on DioError catch (erro, s) {
      log('Erro ao buscar produtos', error: erro, stackTrace: s);
      throw RepositoryExceptions(
          message: 'Erro ao buscar produtos!: ');
    }
    // TODO: implement findAllProducts
    throw UnimplementedError();
  }
}
