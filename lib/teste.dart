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
      ),
      body: carregarSabor()
    );
  }

  bebida() async{
    var url="https://pizzaria-do-careca.000webhostapp.com/dadosBebida.php";//Link do arquivo que carrega os dados
    var res = await http.get(Uri.encodeFull(url));
    var responsBody = json.decode(res.body);

    return responsBody;
  }
  carregarBebida(){
    return FutureBuilder(
        future: bebida(),
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
              return ListTile(
                title: Text("${bebida[index]['nome']}"),
                subtitle: Text("R\$ ${bebida[index]['preco']}"),
              );
            },
          );
        },
      );
  }


  sabor() async{
    var url="https://pizzaria-do-careca.000webhostapp.com/dadosSabor.php";//Link do arquivo que carrega os dados
    var res = await http.get(Uri.encodeFull(url));
    var responsBody = json.decode(res.body);

    return responsBody;
  }
  carregarSabor(){
    return FutureBuilder(
        future: sabor(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List sabor = snapshot.data;
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
            itemCount: sabor.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text("${sabor[index]['nome']}"),
                subtitle: Text("R\$ ${sabor[index]['precoAdd']}"),
              );
            },
          );
        },
      );
  }


  tamanho() async{
    var url="https://pizzaria-do-careca.000webhostapp.com/dadosTamanho.php";//Link do arquivo que carrega os dados
    var res = await http.get(Uri.encodeFull(url));
    var responsBody = json.decode(res.body);

    return responsBody;
  }
  carregarTamanho(){
    return FutureBuilder(
        future: tamanho(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List tamanho = snapshot.data;
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
            itemCount: tamanho.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text("${tamanho[index]['nome']}"),
                subtitle: Text("R\$ ${tamanho[index]['preco']}"),
              );
            },
          );
        },
      );
  }
}

