import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burguer_app/app/core/exceptions/repository_exceptions.dart';
import 'package:vakinha_burguer_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer_app/app/dto/order_dto.dart';
import 'package:vakinha_burguer_app/app/models/payment_Type_model.dart';
import 'package:vakinha_burguer_app/app/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await dio.auth().get('/payment-types');
      return result.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositoryExceptions(message: 'Erro ao buscar formas de pagamento');
      // TODO
    }
    // TODO: implement getAllPaymentsTypes
    throw UnimplementedError();
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await dio.auth().post('/orders', data: {
        'products': order.products
            .map((e) => {'id': e.product.id, 'amount': e.totalPrice})
            .toList(),
        'user_id': '#userAuthRef',
        'address': order.address,
        'CPF': order.document,
        'payment_method_id': order.paymentMethodId
      });
    } on DioError catch (e, s) {
      log('Error ao registrar pedido', error: e, stackTrace: s);
      throw RepositoryExceptions(message: 'Error ao registrar pedido');
    }
  }
}
