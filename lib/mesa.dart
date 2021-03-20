import 'dart:html';

import 'package:flutter/material.dart';

class Mesa extends StatefulWidget {
  @override
  _MesaState createState() => _MesaState();
}

class _MesaState extends State<Mesa> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(),

    );
    return scaffold;

  }
}

/*
GlobalKey<RefreshIndicatorState> refreshKey;


RefreshIndicator(
  key: refreshKey,
  onRefresh: refreshList,
  child: buildListView(),
),


int pos, nMesa;
Color corStatus;
//  String status = "Fechada";

final cor = List<int>.generate(5, (i)=>i);
final status = List<String>.generate(5, (i)=> 'Fechada');
final open = List<bool>.generate(5, (i)=> true);
final itens = List<int>.generate(5, (i)=>i+1);

buildListView(){
  for(int i=0;i<itens.length;i++){
    if(status[i] == "Fechada"){
      open[i] = false;
			cor[i] = 50;
    }
    else{
      open[i] = true;
			cor[i] = 300;
    }
  }

  return ListView.builder(
    itemCount: itens.length,
    itemBuilder: (context,index){
      if(open[index] == true){
        corStatus = Colors.green;
      }
      if(open[index] == false){
        corStatus = Colors.red;
      }

      return Card(
        child: ListTile(
            onTap: (){},
            leading: Icon(MenuIcon.table),
            title: Text('${itens[index]}'),
            subtitle: Text(
              '${status[index]}',
              style: TextStyle(
                  color: corStatus
              ),
            ),
            trailing: IconButton(
              onPressed: (){
                alertDialog(context);
                nMesa = index+1;
                pos = index;
              },
              icon: Icon(Icons.add_shopping_cart),
              iconSize: 40,
            )

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
alertDialog(BuildContext context){
  showCupertinoModalPopup(
    context: context,
    builder: (context){
      return CupertinoActionSheet(
        title: Text(
          'Mesa $nMesa',
          style: TextStyle(
              fontSize: 30,
              color: Colors.blue
          ),
        ),
        cancelButton: CupertinoActionSheetAction(
            onPressed: ()
            {
              Navigator.of(context).pop();
              },
            child: Text("Voltar")
        ),

        actions: <Widget>[

          CupertinoActionSheetAction(
            onPressed: (){
              status[pos] = "Aberta";
              Navigator.of(context).pop();

              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => Pedido()
                )
              );

            },
            child: Text(
              "Pedir",
              style: TextStyle(
                  color: Colors.blue
              ),
            ),
          ),

          CupertinoActionSheetAction(
            onPressed: (){
              if(open[pos]==true){//O que fará se a conta estiver ABERTA
                status[pos] = "Fechada";
                Navigator.of(context).pop();

              }
            },
            child: Text(
              "Fechar Conta",
              style: TextStyle(
                  color: Colors.red[cor[pos]]
              ),
              ),
          ),
        ],
      );
    },
  );
}
*/