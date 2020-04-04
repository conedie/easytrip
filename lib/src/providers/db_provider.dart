import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  //creamos propiedad privada
  static Database _database;
  //constructor privado, que me ayude a que la base no se me este incializando
  static final DBProvider db = DBProvider._();

  //se define el constructor.
  DBProvider._();

  //getter para obtener _database

  Future<Database> get database async {
    if (_database != null) return _database;

    //si no existe instancia de base de datos, entonces la debemos crear
    _database = await initDB();
    return _database;
  }

  initDB() async {
    //donde tenemos la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'EasyDB.db');
    //creamos base de datos

    return await openDatabase(path, version: 0, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE configuracion ('
          'descripcion TEXT,'
          'valor INTEGER'
          ')');
      await db.execute('CREATE TABLE historico ('
          'estacion TEXT,'
          'fecha TEXT'
          ')');
    });
  }

  //INSERTs
  Future insertLogin(descrip, valor) async {
    final db = await database;
    final res = db.rawInsert("INSERT Into configuracion (descripcion, valor)"
        "VALUES ( '$descrip', $valor )");
  }

  Future insertHistorico(estacion, fecha) async {
    final db = await database;
    final res = db.rawInsert("INSERT Into historico (estacion, fecha)"
        "VALUES ( '$estacion', '$fecha' )");
  }

  Future selectLogin(descrip) async {
    final db = await database;
    final res = await db
        .query('configuracion', where: 'descripcion = ?', whereArgs: [descrip]);
    return res.isNotEmpty ? res.first : null;
  }

  Future updateLoginTwo(Map<String, dynamic> data) async {
    final db = await database;
    final res = await db.update('configuracion', data);
    return res;
  }
}
