import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pizzaria/pedido.dart';
import 'package:spinner_input/spinner_input.dart';

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
          return Column(
            children: [
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  child: ListTile(
                    onTap: (){},
                    title: Text("${bebida[index]['nome']}"),
                    subtitle: Text("R\$ ${bebida[index]['preco']}"),
                    trailing: IconButton(
                      onPressed: (){
                        dialogBebida(context);
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

dialogBebida(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      double qtde = 1;
      return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            title: Text("Escolha a quantidade"),
            content: SingleChildScrollView(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quantidade"),
                  SpinnerInput(
                    spinnerValue: qtde,
                    minValue: 1,
                    onChange: (newValue){
                      setState((){
                        qtde = newValue;
                      });
                    },
                  )
                ],
              ),
            ),
            actions: [
              RaisedButton(
                child: Text("Fechar"),
                onPressed: (){
                  Navigator.of(context).pop();
                }
              ),
              RaisedButton(
                child: Text("Adicionar"),
                onPressed: (){
                  Navigator.of(context).pop();
                }
              ),

            ],
          );
        },
      );
    },
  );
}