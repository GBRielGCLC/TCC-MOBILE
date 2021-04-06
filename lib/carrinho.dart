import 'package:flutter/material.dart';
import 'package:pizzaria/metodos/BD/database_helper.dart';

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
      body: body2(),
      bottomNavigationBar: bottom(),
    );
  }
  
  Map bebida={
    'nome' : ['coca','fanta','guarana'],
    'preco' : [5,2,3],
  };

  carregarBebidaCarrinho() async{
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.listarBebida();

    print(queryRows);
    return queryRows;
  }

  body2() {
    return FutureBuilder(
    future: carregarBebidaCarrinho(),
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
                    title: Text("${bebida[index]['nome']}"),
                    subtitle: Text("R\$ ${bebida[index]['preco']}"),
                  ),
                elevation: 3,
                ),
              ),
            ],
          );
        },
      );
    },
  );
  }

  body(){
    return ListView.builder(
      itemCount: bebida['nome'].length,
      itemBuilder: (context,index){

        return Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Dismissible(
              key: ValueKey(index),
              onDismissed: (direction) {
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
                  title: Text("${bebida['nome'][index]}"),
                  subtitle: Text("R\$ ${bebida['preco'][index]}"),
                ),
                elevation: 3,
              ),
            ),
          ],
        );
      },
    );
  }

  bottom(){
    var total = 0;
    for (var i = 0; i < bebida['nome'].length; i++) {
      total+=bebida['preco'][i];
    }
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
            "R\$ "+total.toString(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.green,
            ),
          ),
          ElevatedButton(
            child: Text("Adicionar"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
