import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'login_state.g.dart';

@match
enum LoginStatus {
  initial,
  login,
  success,
  loginError,
  error;
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessege;

  LoginState({
    required this.status,
    this.errorMessege,
  });

  const LoginState.initial()
      : status = LoginStatus.initial,
        errorMessege = null;

  @override
  // TODO: implement props
  List<Object?> get props => [status, errorMessege];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessege,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessege: errorMessege ?? this.errorMessege,
    );
  }
}
