import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notas_fiscais_app/models/nota_fiscal.dart';
import '../../controllers/nota_fiscal_controller.dart';
import '../../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    } catch (e) {
      _showErrorDialog('Erro ao conectar com a API', e.toString());
    }
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
