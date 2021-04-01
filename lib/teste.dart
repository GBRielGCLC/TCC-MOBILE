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
        title: Text("Baixando dados da web", textAlign: TextAlign.center,),
        backgroundColor: Colors.red[900],
        centerTitle: true,
      ),
      body: body()
    );
  }
  body(){
    Map teste={
      'nome' : ['coca','fanta'],
      'preco' : [5,2],
    };
    
  }
/*
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString('aaaaa');
  }*/
}