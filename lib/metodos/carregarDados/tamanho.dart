import 'package:flutter/cupertino.dart';
import 'package:pizzaria/metodos/carregarDados/sabor.dart';
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  child: ListTile(
                    onTap: (){
                      dialogSabor(context, tamanho, index);
                    },
                    title: Text("${tamanho[index]['nome']}"),
                    subtitle: Text("R\$ ${tamanho[index]['preco']}"),
                    trailing: IconButton(
                      onPressed: (){
                        dialogSabor(context,tamanho, index);
                      },
                      icon: Icon(Icons.add_shopping_cart),
                      iconSize: 30,
                    ),
                  ),
                  elevation: 3,
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

dialogSabor(BuildContext context, tamanho, index) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            title: Text("${tamanho[index]['nome']} até ${tamanho[index]['qtdeSabor']} sabores"),
            content: sabor(tamanho,index),
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text("Fechar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: (){},
                    ),
                    ElevatedButton(
                      child: Text("Adicionar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}