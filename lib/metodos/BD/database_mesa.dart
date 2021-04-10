import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spinner_input/spinner_input.dart';


double qtde=getQuantidade();

dialogQtde(BuildContext context){
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            title: Text('Quantidade de mesas'),
            content: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinnerInput(
                    spinnerValue: qtde,
                    minValue: 0,
                    plusButton: SpinnerButtonStyle(elevation: 0, color: Colors.blue),
                    minusButton: SpinnerButtonStyle(elevation: 0, color: Colors.red),
                    middleNumberWidth: 40,
                    middleNumberBackground: Colors.white,
                    onChange: (newValue){
                      setState((){
                        qtde = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
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
                      onPressed: (){
                        getQuantidade();
                        //Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text("Atualizar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        insertQuantidade();
                        Navigator.of(context).pop();
                      },
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

const _baseUrl = 'https://pizzaria-do-careca-default-rtdb.firebaseio.com/';

insertQuantidade() async{
  await http.patch(
    "$_baseUrl/mesas.json",
    body: json.encode(
      {
        'qtde': qtde,
      }
    )
  );
}

getQuantidade() async{
  final response = await http.read("$_baseUrl/mesas.json");
  return response;
}