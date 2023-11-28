import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ClimatePage extends StatefulWidget {
  @override
  _ClimaNowPage createState() => _ClimaNowPage();
}

class _ClimaNowPage extends State<ClimatePage> {
  final TextEditingController _cityController = TextEditingController();
  String _temperatureMax = '';
  String _temperatureMin = '';
  String _weatherState = '';

  Future<void> fetchWeather(String city) async {
    final apiKey = 'd8e593330e044e1e8af02146232811'; // Insira sua chave da WeatherAPI aqui
    final apiUrl = 'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=1&lang=pt';
    print(city);

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          _temperatureMax = jsonData['forecast']['forecastday'][0]['day']['maxtemp_c'].toString();
          _temperatureMin = jsonData['forecast']['forecastday'][0]['day']['mintemp_c'].toString();
          _weatherState = jsonData['forecast']['forecastday'][0]['day']['condition']['text'];
        });
      } else {
        print('ERROOOOOOOOOOOOOOOOOOOOOOOOOO 0001');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('ERROOOOOOOOOOOOOOOOOOOOOOOOOO 0002');
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Clima Agora!'),
      backgroundColor: Colors.blue,
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Insira a cidade desejada e saiba as temperaturas mínima e máxima atualizadas juntamente com o estado meteorológico!'),
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Insira o nome da cidade',
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              fetchWeather(_cityController.text);
            },
            child: Text('Consultar Clima!'),
          ),
          SizedBox(height: 20.0),
          Text('Temperatura Max: $_temperatureMax°C'),
          Text('Temperature Min : $_temperatureMin°C'),
          Text('Estado Meteorológico: $_weatherState'),
        ],
      ),
    ),
  );
}