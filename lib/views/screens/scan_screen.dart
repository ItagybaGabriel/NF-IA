// scan.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notas_fiscais_app/controllers/nota_fiscal_controller.dart';
import 'package:notas_fiscais_app/models/nota_fiscal.dart';
import 'package:notas_fiscais_app/services/api_service.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final NotaFiscalController controller = NotaFiscalController(ApiService());
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final List<NotaFiscal> notas = [];

  Future<void> _pickImage() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Câmera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeria'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() => _imageFile = image);
      }
    }
  }

  void _sendToAPI() async {
    if (_imageFile == null) {
      _showErrorDialog('Erro', 'Nenhuma imagem selecionada.');
      return;
    }
    try {
      final notaFiscal = await controller.getNotaFiscalInfo(_imageFile!);
      _showErrorDialog(
          'Sucesso', 'Categoria: ${notaFiscal.empresa.cnaeDescricao}');
      notas.add(notaFiscal);
      _saveNotas();
    } catch (e) {
      _showErrorDialog('Erro ao conectar com a API', e.toString());
    }
  }

  Future<void> _saveNotas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<NotaFiscal> currentNotas = await _loadNotas();
    currentNotas.addAll(notas);
    String notasString =
        jsonEncode(currentNotas.map((nota) => nota.toJson()).toList());
    prefs.setString('notas', notasString);
  }

  Future<List<NotaFiscal>> _loadNotas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notasString = prefs.getString('notas');
    if (notasString != null) {
      List<dynamic> jsonList = jsonDecode(notasString);
      return jsonList.map((json) => NotaFiscal.fromJson(json)).toList();
    }
    return [];
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Captura de Nota Fiscal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              child: _imageFile != null
                  ? Image.file(File(_imageFile!.path), fit: BoxFit.contain)
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.all(
                            20.0), // Ajuste para um melhor espaço interno
                        child: Text(
                          'Toque no botão abaixo para carregar uma imagem',
                          textAlign: TextAlign
                              .center, // Centraliza o texto horizontalmente
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .color! // Cor do texto para contraste adequado
                              ),
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: _pickImage,
                child: Text(_imageFile == null
                    ? 'Selecionar Imagem'
                    : 'Substituir Imagem'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary, // Cor de fundo do botão
                    foregroundColor: Theme.of(context)
                        .colorScheme
                        .onPrimary), // Cor do texto do botão),
              ),
            ),
            if (_imageFile != null) SizedBox(height: 16),
            if (_imageFile != null)
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _sendToAPI,
                  child: Text(
                    'Extrair Informações',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
