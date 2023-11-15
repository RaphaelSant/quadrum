import 'package:flutter/material.dart';

class ConversionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Conversão'),
    ),
    body:  Center(child: Text('Converter Aqui!', style: TextStyle(fontSize: 60),),),
  );
}