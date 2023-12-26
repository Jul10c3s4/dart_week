// é o cara que vai centralizar todas as autenticações
import 'package:vakinha_burguer_app/app/models/auth_model.dart';

abstract class AuthRepository {
  Future<void> register(String name, String email, String password);

  Future<AuthModel> login(String email, String password);
}
