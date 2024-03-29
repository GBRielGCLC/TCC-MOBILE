import 'package:flutter/material.dart';
import 'package:pizzaria/metodos/carregarDados/bebida.dart';
import 'package:pizzaria/metodos/carregarDados/tamanho.dart';


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
          unselectedLabelColor: Colors.red[200],
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: <Widget>[
            new Tab(text: "Pizza"),
            new Tab(text: "Bebida"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          tamanho(),
          bebida(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/carrinho");
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

}

