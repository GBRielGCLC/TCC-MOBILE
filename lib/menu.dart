import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Icons/menu_icons.dart';
import 'mesas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Menu()
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("SPP"),
          centerTitle: true,
          backgroundColor: Colors.red[900],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) => Mesa()
                              )
                            );
                          },
                          icon: Icon(MenuIcon.table),
                          color: Colors.red[900],
                          iconSize: 75,

                          tooltip: 'Mesa',
                        ),
                      ),
                    ),
                    Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(MenuIcon.entrega),
                            color: Colors.red[900],
                            iconSize: 75,

                            tooltip: 'Delivery',
                          ),
                        )
                    ),

                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(MenuIcon.pizzaria),
                            color: Colors.red[900],
                            iconSize: 75,

                            tooltip: 'Retirada',
                          ),
                        )
                    ),
                    Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(MenuIcon.config),
                            color: Colors.red[900],
                            iconSize: 75,

                            tooltip: 'Configurações',
                          ),
                        )
                    ),

                  ]
              )
            ],
          ),
          color: Colors.white,
        )
    );
  }
}