import 'package:flutter/material.dart';

class Carrinho extends StatefulWidget {
  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: body(),
      bottomNavigationBar: bottom(),
    );
  }

  body() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Dismissible(
          key: ValueKey(1),
          onDismissed: (direction) {
            print(direction);
          },
          background: Container(
            color: Colors.yellow,
            child: Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 30,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 30,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
          ),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.local_pizza_outlined,size: 30,),
              title: Text("Grande"),
              subtitle: Text("Calabresa, Marguerita",),
            ),
            elevation: 3,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Dismissible(
          key: ValueKey(2),
          onDismissed: (direction) {
            print(direction);
          },
          background: Container(
            color: Colors.yellow,
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
          ),
          child: Card(
            child: ListTile(
              title: Text("Guaraná 1l"),
              subtitle: Text(""),
            ),
            elevation: 3,
          ),
        ),
      ],
    );
  }

  bottom(){
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: MediaQuery.of(context).size.width*0.1,
      ),
      height: MediaQuery.of(context).size.height*0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(
          offset: Offset(0,-15),
          blurRadius: 20,
          color: Colors.grey[200],
        )]
      ),
      child: Column(
        children: [
          Text(
            "Total:",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            "R\$ 10,00",
            style: TextStyle(
              fontSize: 20,
              color: Colors.green,
            ),
          ),
          RaisedButton(
            child: Text("Adicionar"),
            color: Colors.green,
            textColor: Colors.white,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
