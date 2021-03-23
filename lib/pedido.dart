import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pedido extends StatefulWidget {
  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Pedido"),
        centerTitle: true,
        backgroundColor: Colors.red[900],
        bottom: new TabBar(
          unselectedLabelColor: Colors.red[300],
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: <Widget>[
            new Tab(text: "Tamanho"),
            new Tab(text: "Bebida"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          carregarTamanho(),
          carregarBebida(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
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
              return Column(
                children: [
                  SizedBox(height: 10.0),
                  Card(
                    child: ListTile(
                      title: Text("${tamanho[index]['nome']}"),
                      subtitle: Text("R\$ ${tamanho[index]['preco']}"),
                    ),
                    elevation: 15,
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
              return Card(
                child: ListTile(
                  title: Text("${bebida[index]['nome']}"),
                  subtitle: Text("R\$ ${bebida[index]['preco']}"),
                ),
                elevation: 15,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              );
            },
          );
        },
      );
  }
