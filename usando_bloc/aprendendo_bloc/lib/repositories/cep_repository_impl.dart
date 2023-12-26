import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:usando_bloc/models/endereco_model.dart';

import 'cep_repository.dart';

class CepRepositoryImpl implements CepRepository {
  @override
  Future<EnderecoModel> getCep(String cep) async {
    try {
      final result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      print(result.data);
      return EnderecoModel.fromJson(result.data);
    } on DioError catch (e) {
      log('Erro ao buscar CEP');
      throw Exception('Erro ao buscar Cep');
    }
  }
}
