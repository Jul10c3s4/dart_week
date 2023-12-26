class EnderecoModel {
  EnderecoModel({
    required this.uf,
    required this.localidade,
    required this.bairro,
  });
  late final String uf;
  late final String localidade;
  late final String bairro;
  late final String logra;
  late final String comple;

  EnderecoModel.fromJson(Map<String, dynamic> json) {
    uf = json['uf'];
    localidade = json['localidade'];
    bairro = json['bairro'];
    logra = json['logradouro'];
    comple = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uf'] = uf;
    _data['localidade'] = localidade;
    _data['logradouro'] = comple;
    _data['complemento'] = comple;
    return _data;
  }
}
