// lib/controllers/nota_fiscal_controller.dart
import 'package:image_picker/image_picker.dart';

import '../models/nota_fiscal.dart';
import '../services/api_service.dart';

class NotaFiscalController {
  final ApiService apiService;

  NotaFiscalController(this.apiService);

  Future<NotaFiscal> getNotaFiscalInfo(XFile image) {
    return apiService.fetchNotaFiscal(image);
  }
}
