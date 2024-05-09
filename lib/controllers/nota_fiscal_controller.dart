// lib/controllers/nota_fiscal_controller.dart
import '../models/nota_fiscal.dart';
import '../services/api_service.dart';

class NotaFiscalController {
  final ApiService apiService;

  NotaFiscalController(this.apiService);

  Future<NotaFiscal> getNotaFiscalInfo(String imagePath) {
    return apiService.fetchNotaFiscal(imagePath);
  }
}
