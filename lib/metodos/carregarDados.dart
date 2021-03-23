import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

carregarTamanho() async{
  var url="https://pizzaria-do-careca.000webhostapp.com/dadosTamanho.php";//Link do arquivo que carrega os dados
  var res = await http.get(Uri.encodeFull(url));
  var responsBody = json.decode(res.body);

  return responsBody;
}
tamanho(){
  return FutureBuilder(
      future: carregarTamanho(),
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
            return Column(
              children: [
                SizedBox(height: 10.0),
                Card(
                  child: ListTile(
                    title: Text("${tamanho[index]['nome']}"),
                    subtitle: Text("R\$ ${tamanho[index]['preco']}"),
                  ),
                  elevation: 3,
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ],
            );
          },
        );
      },
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
            return Card(
              child: ListTile(
                title: Text("${bebida[index]['nome']}"),
                subtitle: Text("R\$ ${bebida[index]['preco']}"),
              ),
              elevation: 3,
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            );
          },
        );
      },
    );
}

carregarSabor() async{
  var url="https://pizzaria-do-careca.000webhostapp.com/dadosSabor.php";//Link do arquivo que carrega os dados
  var res = await http.get(Uri.encodeFull(url));
  var responsBody = json.decode(res.body);

  return responsBody;
}
sabor(){
  return FutureBuilder(
      future: carregarSabor(),
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