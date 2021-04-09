import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pizzaria/metodos/BD/database_helper.dart';
import 'package:spinner_input/spinner_input.dart';

class Carrinho extends StatefulWidget {
  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  final _streamControllerBottom = StreamController<double>();
  final _streamControllerBody = StreamController<List>();

  @override
  void initState(){
    super.initState();

    carregarBebidaCarrinho();
    calcularValorTotal();
  }

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
 

  carregarBebidaCarrinho() async{
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.listarBebida();
    _streamControllerBody.add(queryRows);
  }

  var total;
  body() {
    return StreamBuilder(
      stream: _streamControllerBody.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List bebida = snapshot.data;
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: Text(""),
          );
        }
        if(snapshot.hasError){
          return Center(
            child: Text("Erro"),
          );
        }
        return Container(
          margin: EdgeInsets.only(top:10),
          child: ListView.builder(
            itemCount: bebida.length,
            itemBuilder: (context, index){
              double qtde = bebida[index]['qtde'].toDouble();
              int id = bebida[index]['id'].toInt();
              return Dismissible(
                key: ValueKey(id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async{
                  await DatabaseHelper.instance.deleteBebida(id);
                  calcularValorTotal();
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    child: ListTile(
                      title: Text("${bebida[index]['nome']}"),
                      subtitle: Text("R\$ ${bebida[index]['preco']}"),
                      trailing: SpinnerInput(
                        spinnerValue: qtde,
                        minValue: 1,
                        plusButton: SpinnerButtonStyle(elevation: 0, color: Colors.blue),
                        minusButton: SpinnerButtonStyle(elevation: 0, color: Colors.red),
                        middleNumberWidth: 40,
                        middleNumberBackground: Colors.white,
                        onChange: (newValue){
                          setState((){
                            qtde = newValue;
                            DatabaseHelper.instance.updateBebida(id, qtde.toInt());
                            carregarBebidaCarrinho();
                            calcularValorTotal();
                          });
                        },
                      ),
                    ),
                  elevation: 3,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  calcularValorTotal() async{
    total = await DatabaseHelper.instance.calcularValor();
    _streamControllerBottom.add(total);
  }
  bottom(){
    return StreamBuilder(
      stream: _streamControllerBottom.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        double total = snapshot.data;
        if(snapshot.hasError){
          return Center(
            child: Text("Erro"),
          );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text("Limpar"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: (){
                      dialogConfirmar();
                    },
                  ),
                  ElevatedButton(
                    child: Text("Adicionar"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: (){},
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  dialogConfirmar(){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Limpar carrinho"),
          content: Text("Tem certeza?"),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text("Cancelar"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text("Limpar"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      DatabaseHelper.instance.limpar();
                      Navigator.of(context).pop();
                      carregarBebidaCarrinho();
                      calcularValorTotal();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }

}