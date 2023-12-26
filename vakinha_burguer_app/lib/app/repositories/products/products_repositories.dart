import 'package:vakinha_burguer_app/app/models/product_model.dart';

abstract class ProductsRepositories {
  Future<List<ProductModel>> findAllProducts();
}
