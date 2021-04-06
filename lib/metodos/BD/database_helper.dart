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
    return await db.insert("bebida", row);
  }

  Future<List<Map<String,dynamic>>> listarBebida() async{  
    Database db = await instance.database;
    return await db.query("bebida");
  }



}