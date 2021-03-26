import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spinner_input/spinner_input.dart';

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
            double qtde=0;
            return StatefulBuilder(
              builder: (context, setState){
                return ListTile(
                  title: Text("${sabor[index]['nome']}"),
                  subtitle: Text("${sabor[index]['descricao']}"),
                  trailing: SpinnerInput(
                    spinnerValue: qtde,
                    onChange: (newValue){
                      setState((){
                        qtde = newValue;
                      });
                    },
                  ),
                );
              }
            );
          },
        );
      },
    );
}