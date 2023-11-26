import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPage createState() => _ConversionPage();
}

class _ConversionPage extends State<ConversionPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _result = 0.0;
  double _valorDesejado = 0.0;
  String _name = "";
  String _fromCurrency = 'USD';
  TextEditingController _controller = TextEditingController();



  Future<double> _convertCurrency() async {
    final String apiKey = '9b2d4f25'; // Chave da API do HGBrasil
    final String url = 'https://api.hgbrasil.com/finance?key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double inputValue = double.tryParse(_controller.text) ?? 0.0;
      _valorDesejado = inputValue;
      double convertedValue = data['results']['currencies'][_fromCurrency]['buy'] * inputValue;
      return convertedValue;
    } else {
      throw Exception('Falha ao carregar os dados da API');
    }
  }

  Future<String> _nameConvertCurrency() async {
    final String apiKey = '9b2d4f25'; // Chave da API do HGBrasil
    final String url = 'https://api.hgbrasil.com/finance?key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String nameConvertedValue = data['results']['currencies'][_fromCurrency]['name'];
      return nameConvertedValue;
    } else {
      throw Exception('Falha ao carregar os dados da API');
    }
  }

  void _handleSubmit() async {

    if (_formKey.currentState!.validate()) {
      double result = await _convertCurrency();
      String name = await _nameConvertCurrency();
      setState(() {
        _result = result;
        _name = name;
      });
    }
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Conversão do Real Brasileiro'),
      backgroundColor: Colors.blue,
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _fromCurrency,
              onChanged: (newValue) {
                setState(() {
                  _fromCurrency = newValue!;
                });
              },
              items: <String>['USD', 'EUR', 'JPY', 'GBP', 'ARS', 'CAD', 'AUD', 'CNY', 'BTC'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Moeda de Destino',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um valor';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Valor desejado da moeda de destino',
              ),
            ),
            SizedBox(height: 20),


            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Converter'),
            ),
            SizedBox(height: 20),
            Text(
              _valorDesejado.toStringAsFixed(2) + ' $_name = ' + _result.toStringAsFixed(2) + ' Reais',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    ),
  );
}