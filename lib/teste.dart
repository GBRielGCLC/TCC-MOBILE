import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  getMethod()async{
    
  }

  bebida() async{
    var url="https://pizzaria-do-careca.000webhostapp.com/baixarDados.php";
    var res = await http.get(Uri.encodeFull(url));
    var responsBody = json.decode(res.body);

    return responsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baixando dados da web", textAlign: TextAlign.center,),
      ),
      body: FutureBuilder(
        future: bebida(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List snap = snapshot.data;
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
            itemCount: snap.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text("${snap[index]['nome']}"),
                subtitle: Text("${snap[index]['idBebida']}"),
              );
            },
          );
        },
      ),
    );
  }
}