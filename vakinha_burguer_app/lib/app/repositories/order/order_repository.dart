import '../../dto/order_dto.dart';
import '../../models/payment_Type_model.dart';

abstract class OrderRepository {
  Future<List<PaymentTypeModel>> getAllPaymentsTypes();

  Future<void> saveOrder(OrderDto order);
}
