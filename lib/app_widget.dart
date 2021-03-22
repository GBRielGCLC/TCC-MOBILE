import 'package:flutter/material.dart';
import 'package:pizzaria/pedido.dart';
import 'package:pizzaria/teste.dart';

import 'mesa.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Mesa(),
        "/pedido": (context) => Pedido(),
        "/teste": (context) => Teste(),
      },
    );
  }
}
