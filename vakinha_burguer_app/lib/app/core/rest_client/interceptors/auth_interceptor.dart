import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_burguer_app/app/core/global/global_context.dart';

class AuthInterceptor extends Interceptor {
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken').toString();
    options.headers['Authorization'] = 'Bearer $accessToken';

    handler.next(options);
  }

  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      //redirecionar para a tela de home
      GlobalContext.i.loginExpire();
    } else {
      handler.next(err);  
    }
  }
}
