import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste", textAlign: TextAlign.center,),
        backgroundColor: Colors.red[900],
        centerTitle: true,
      ),
      body: body()
    );
  }
  body(){
  }

}