// lib/models/nota_fiscal.dart
class NotaFiscal {
  final String cnpj;
  final String descricao;
  final double valor;

  NotaFiscal(
      {required this.cnpj, required this.descricao, required this.valor});

  factory NotaFiscal.fromJson(Map<String, dynamic> json) {
    return NotaFiscal(
      cnpj: json['cnpj'],
      descricao: json['descricao'],
      valor: double.parse(json['valor'].toString()),
    );
  }
}
