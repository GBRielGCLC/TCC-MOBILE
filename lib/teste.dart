import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      body: bebida()
    );
  }

  carregarBebida() async{
    var url="https://pizzaria-do-careca.000webhostapp.com/dadosBebida.php";//Link do arquivo que carrega os dados
    var res = await http.get(Uri.encodeFull(url));
    var responsBody = json.decode(res.body);

    return responsBody;
  }
  bebida(){
    return FutureBuilder(
        future: carregarBebida(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List bebida = snapshot.data;
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Center(
              child: Text("Erro"),
            );

          }
          return ListView.builder(
            itemCount: bebida.length,
            itemBuilder: (context, index){
              return DropdownButton(
                hint: Text("Select"),
              );
            },
          );
        },
      );
  }
}