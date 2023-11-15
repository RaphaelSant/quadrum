import 'package:flutter/material.dart';

class ClimatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Clima'),
    ),
    body:  Center(child: Text('Climatização Aqui', style: TextStyle(fontSize: 60),),),
  );
}