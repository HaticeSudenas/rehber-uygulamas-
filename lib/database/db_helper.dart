import 'dart:async';

import 'package:flutter_project_1/model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  Future get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var DbFolder = await getDatabasesPath();
    String path = join(DbFolder, "contact.db");
    return await openDatabase(path, onCreate: _oncreate, version: 1);
  }

  FutureOr<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Contact(id INTEGER PRIMARY KEY,name TEXT,phone_number TEXT,avatar TEXT)");
  }

 /* Future<List<Contact>> getContacts() async {
    var dbClient = await db;
    var result=dbClient.query("contact",orderBy:"name");
    return result.map((data)=>Contact.fromMap(data)).toList();
  }*/


  Future getContacts() async {
    var dbClient = await db;

    final List<Map<String, dynamic>> result = await dbClient.query('contact');
    return result.map((data)=>Contact.fromMap(data)).toList();
  }
  Future insertContacts(Contact contact) async{
    var dbClient=await db;
    return await dbClient.insert("Contact",contact.toMap());

  }
  Future updateContact(Contact contact) async{
    var dbClient=await db;
    return await dbClient.update("Contact",contact.toMap(),where:"id=?",whereArgs:[contact.id]);
  }
  Future removeContacts(int id) async{
    var dbClient=await db;
    return await dbClient.delete("contact",where:"id=?",whereArgs:[id]);
  }
}
