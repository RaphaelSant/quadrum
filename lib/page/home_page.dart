import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _pokemonController = TextEditingController();
  String _pokemonName = '';
  String _pokemonImage = '';

  Future<void> fetchPokemon(String nameOrId) async {
    final apiUrl = 'https://pokeapi.co/api/v2/pokemon/$nameOrId';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          _pokemonName = jsonData['name'];
          _pokemonImage = jsonData['sprites']['front_default'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('PokeDex'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _pokemonController,
            decoration: InputDecoration(
              labelText: 'Enter Pokemon name or ID',
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              fetchPokemon(_pokemonController.text.toLowerCase());
            },
            child: Text('Search'),
          ),
          SizedBox(height: 20.0),
          _pokemonName.isNotEmpty
              ? Column(
            children: [
              Text(
                'Name: $_pokemonName',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _pokemonImage.isNotEmpty
                  ? Image.network(_pokemonImage)
                  : SizedBox(),
            ],
          )
              : SizedBox(),
        ],
      ),
    ),
  );
}