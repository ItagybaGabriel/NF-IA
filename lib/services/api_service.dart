// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../models/nota_fiscal.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000';

  Future<NotaFiscal> fetchNotaFiscal(XFile image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    var body = json.encode({'image': base64Image});
    print(body);
    print(base64Image);

    var response = await http.post(Uri.parse('$baseUrl/invoice'),
        body: body, headers: {"content-type": "application/json"});
    print(response.body);

    if (response.statusCode == 200) {
      return NotaFiscal.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
