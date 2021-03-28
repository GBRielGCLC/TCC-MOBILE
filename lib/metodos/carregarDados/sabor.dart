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
sabor(tamanho, indexTamanho){
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
        List disp;
        bool existe2;
        var id = "${tamanho[indexTamanho]['idPizza']}";
        for (var i = 0; i < sabor.length; i++) {
          var aux = "${sabor[i]['disponibilidade']}"; 
          disp = aux.split(",");

          bool existe = false;
          for (var j = 0; j < disp.length; j++) {//verificar se o sabor está disponível no tamanho
            if("${disp[j]}"==id){
              existe2 = true;
            }
            else{
              existe2 = false;
            }
            
            if(existe2 == true){//para saber se está disponivel (prescisa ser feito assim por causa da repetição)
              existe = true;
            }
          }
          if (existe==false) {
            sabor.removeAt(i);
          }
        }


        return Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
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
          ),
        );
      },
    );
}