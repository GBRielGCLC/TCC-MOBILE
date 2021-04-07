import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizzaria/metodos/BD/database_helper.dart';
import 'dart:convert';
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
                    onTap: (){
                      dialogBebida(context, bebida, index);
                    },
                    title: Text("${bebida[index]['nome']}"),
                    subtitle: Text("R\$ ${bebida[index]['preco']}"),
                    trailing: IconButton(
                      onPressed: (){
                        dialogBebida(context, bebida, index);
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

dialogBebida(BuildContext context, bebida, index) {
  showDialog(
    context: context,
    builder: (context) {
      double qtde = 1;
      return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            title: Text("${bebida[index]['nome']}"),
            content: SingleChildScrollView(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quantidade"),
                  SpinnerInput(
                    spinnerValue: qtde,
                    minValue: 1,
                    plusButton: SpinnerButtonStyle(elevation: 0, color: Colors.blue),
                    minusButton: SpinnerButtonStyle(elevation: 0, color: Colors.red),
                    middleNumberWidth: 40,
                    middleNumberBackground: Colors.white,
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
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text("Adicionar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () async{
                        DatabaseHelper.instance.insertBebida({
                          'id' : bebida[index]['idBebida'],
                          'nome' : bebida[index]['nome'],
                          'preco' : bebida[index]['preco'],
                          'qtde' : qtde,
                        }); 
                        
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
