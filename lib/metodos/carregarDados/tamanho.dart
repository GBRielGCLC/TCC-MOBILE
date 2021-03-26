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
                      title: Text("${tamanho[index]['nome']}"),
                      subtitle: Text("R\$ ${tamanho[index]['preco']}"),
                      trailing: IconButton(
                        onPressed: (){},
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