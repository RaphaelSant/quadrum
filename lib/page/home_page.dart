import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text('Página Inicial'),
    ),
    body:  Center(child: Text('Home ' + count.toString(), style: TextStyle(fontSize: 60),),),
    floatingActionButton: FloatingActionButton(
      onPressed: increment,
    ),
  );
}