import 'package:flutter/material.dart';

class Pedido extends StatefulWidget {
  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> with SingleTickerProviderStateMixin{
  TabController _tabController;
  
  
  @override
  void initState(){
    _tabController = new TabController(length: 3, vsync: this);
  }
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text("SPP"),
          centerTitle: true,
          backgroundColor: Colors.red[900],

          bottom: new TabBar(
						unselectedLabelColor: Colors.red[300],
						indicatorColor: Colors.white,
            controller: _tabController,
            tabs: <Widget>[
              new Tab(text: "Tamanho"),
              new Tab(text: "Sabor"),
              new Tab(text: "Bebida"),
            ],
          ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Tamanho(),
          Text("2"),
          Text("3"), 
        ],
      ),

    );
  }
}

final cor = List<int>.generate(2, (i)=>i);
final status = List<String>.generate(2, (i)=> 'Pequena');
final open = List<bool>.generate(2, (i)=> true);
final itens = List<int>.generate(2, (i)=>i+1);

Tamanho(){
  return ListView.builder(
    itemCount: itens.length,
    itemBuilder: (context,index){

      return Card(
        child: ListTile(
            onTap: (){},
            title: Text('${itens[index]}'),
            subtitle: Text(
              '${status[index]}',
            ),

        ),
        elevation: 15,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      );
    },
  );
}
