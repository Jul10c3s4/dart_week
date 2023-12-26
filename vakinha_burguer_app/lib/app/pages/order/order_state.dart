import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:vakinha_burguer_app/app/dto/order_product_dto.dart';
import 'package:vakinha_burguer_app/app/models/payment_Type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {loading, initial, loaded, error, updateOrder, confirmRemoveProduct, emptyBag, success}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypeModel> paymentTypes;
  final String? errorMessege;

  const OrderState(
      {required this.status,
      required this.orderProducts,
      required this.paymentTypes,
      this.errorMessege});

  const OrderState.initial()
      : status = OrderStatus.initial,
        orderProducts = const [],
        paymentTypes = const [],
        errorMessege = null;

  double get totalOrder => orderProducts.fold(
      0.0, (previousValue, element) => previousValue + element.totalPrice);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, orderProducts, paymentTypes, errorMessege];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessege,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProducts: orderProducts ?? this.orderProducts,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessege: errorMessege ?? this.errorMessege,
    );
  }
}

class OrderConfirmDeleteProductState extends OrderState {
  final OrderProductDto orderProduct;
  final int index;

  const OrderConfirmDeleteProductState({
    required this.orderProduct,
    required this.index,
    required super.status, 
    required super.orderProducts, 
    required super.paymentTypes,
    super.errorMessege,
  });
}