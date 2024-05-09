// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nota_fiscal.dart';

class ApiService {
  final String baseUrl = 'https://api.example.com';

  Future<NotaFiscal> fetchNotaFiscal(String imagePath) async {
    var response = await http
        .post(Uri.parse('$baseUrl/analyze'), body: {'image': imagePath});

    if (response.statusCode == 200) {
      return NotaFiscal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
