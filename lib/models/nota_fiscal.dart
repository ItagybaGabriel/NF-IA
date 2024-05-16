// lib/models/nota_fiscal.dart
class NotaFiscal {
  final String valor;
  final Empresa empresa;

  NotaFiscal({required this.empresa, required this.valor});

  factory NotaFiscal.fromJson(Map<String, dynamic> json) {
    return NotaFiscal(
        valor: json['total'], empresa: Empresa.fromJson(json['empresa']));
  }
}

class Empresa {
  final String? cnpj;
  final String? cnaeDescricao;
  final String? dataAbertura;
  final String? email;
  final String? nomeFantasia;
  final String? razaoSocial;
  final String? status;
  final String? telefone;
  final String? ddd;
  final Local? enderecoCompleto;

  Empresa({
    this.cnpj,
    this.cnaeDescricao,
    this.dataAbertura,
    this.email,
    this.nomeFantasia,
    this.razaoSocial,
    this.status,
    this.telefone,
    this.enderecoCompleto,
    this.ddd,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    var empresa = Empresa(
        cnpj: json['CNPJ'],
        cnaeDescricao: json['CNAE PRINCIPAL DESCRICAO'],
        dataAbertura: json['DATA ABERTURA'],
        email: json['EMAIL'],
        nomeFantasia: json['NOME FANTASIA'],
        razaoSocial: json['RAZAO SOCIAL'],
        status: json['STATUS'],
        telefone: json['TELEFONE'],
        enderecoCompleto: Local.fromJson(json));
    return empresa;
  }
}

class Local {
  final String? bairro;
  final String? cep;
  final String? logradouro;
  final String? municipio;
  final String? numero;
  final String? tipoLogradouro;
  final String? uf;
  final String? complemento;

  Local({
    this.bairro,
    this.cep,
    this.logradouro,
    this.municipio,
    this.numero,
    this.tipoLogradouro,
    this.uf,
    this.complemento,
  });

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
        bairro: json['BAIRRO'],
        cep: json['CEP'],
        logradouro: json['LOGRADOURO'],
        municipio: json['MUNICIPIO'],
        numero: json['NUMERO'],
        tipoLogradouro: json['TIPO LOGRADOURO'],
        uf: json['UF'],
        complemento: json['COMPLEMENTO']);
  }
}
