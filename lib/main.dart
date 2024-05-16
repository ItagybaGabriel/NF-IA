import 'package:flutter/material.dart';
import 'package:notas_fiscais_app/views/screens/main_screen.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas Fiscais App',
      theme: AppTheme.themeData, // Usando o tema personalizado
      home: MainScreen(),
    );
  }
}
