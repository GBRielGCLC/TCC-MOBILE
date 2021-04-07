import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper{


  static final _dbName = 'carrinho.bd';
  static final _dbVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async{
    if (_database!=null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);
    return await openDatabase(path,version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version){ 
    db.execute(
      '''
      CREATE TABLE bebida(
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL,
        preco DOUBLE NOT NULL,
        qtde INTEGER NOT NULL )
      '''
    );
  }

  Future<int> insertBebida(Map<String,dynamic> row) async{
    Database db = await instance.database;
    var id = row['id'];
    var result =  await db.rawQuery("SELECT * from bebida where id="+id);
    if (result.isNotEmpty) {
      print("existe");
    }
    else{
      return await db.insert("bebida", row);
    }
  }

  Future<List<Map<String,dynamic>>> listarBebida() async{  
    Database db = await instance.database;
    return await db.query("bebida");
  }

  Future<int> deleteBebida(int id) async{
    Database db = await instance.database;
    return await db.delete("bebida",where: 'id = ?',whereArgs: [id]);
  }

  Future<int> updateBebida(int id, int qtde) async{
    Database db = await instance.database;
    await db.rawQuery("UPDATE bebida SET qtde="+qtde.toString()+" where id="+id.toString());
  }


  Future<double> calcularValor() async{
    Database db = await instance.database;
    var bebida =  await db.rawQuery("SELECT preco,qtde from bebida");

    double total=0,preco=0;
    int qtde=0;

    for (var i = 0; i < bebida.length; i++) {
      qtde = bebida[i]["qtde"];
      preco = bebida[i]["preco"];
      total += preco*qtde;
    }
    return total;
  }

  Future<int> limpar() async{
    Database db = await instance.database;
    return await db.delete("bebida");
  }

}