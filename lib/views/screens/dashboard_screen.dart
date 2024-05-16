// dashboard.dart

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:notas_fiscais_app/models/nota_fiscal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<NotaFiscal> notas = [];
  Map<String, double> categoryTotals = {};

  @override
  void initState() {
    super.initState();
    _loadNotas();
  }

  Future<void> _loadNotas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notasString = prefs.getString('notas');
    if (notasString != null) {
      List<dynamic> jsonList = jsonDecode(notasString);
      List<NotaFiscal> loadedNotas =
          jsonList.map((json) => NotaFiscal.fromJson(json)).toList();
      setState(() {
        notas = loadedNotas;
        _calculateCategoryTotals();
      });
    }
  }

  void _calculateCategoryTotals() {
    Map<String, double> totals = {};
    for (var nota in notas) {
      String category = nota.empresa.cnaeDescricao ?? 'Desconhecida';
      double valor = double.parse(
          nota.valor.replaceAll(',', '.')); // Substitua a vírgula por ponto
      totals[category] = (totals[category] ?? 0.0) + valor;
    }
    setState(() {
      categoryTotals = totals;
    });
  }

  void _deleteNota(int index) {
    setState(() {
      notas.removeAt(index);
      _saveNotas();
      _calculateCategoryTotals();
    });
  }

  Future<void> _saveNotas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notasString =
        jsonEncode(notas.map((nota) => nota.toJson()).toList());
    prefs.setString('notas', notasString);
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartData, String>> series = [
      charts.Series(
        id: 'Categories',
        data: categoryTotals.entries
            .map((entry) => ChartData(entry.key, entry.value))
            .toList(),
        domainFn: (ChartData data, _) => data.category,
        measureFn: (ChartData data, _) => data.value,
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                child: charts.PieChart(series),
              ),
              SizedBox(height: 20),
              Text(
                'Total: R\$ ${categoryTotals.values.fold(0.0, (sum, value) => sum + value).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: notas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        notas[index].empresa.razaoSocial ?? 'Desconhecida'),
                    subtitle: Text('Valor: R\$ ${notas[index].valor}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNota(index),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
