import 'package:pass_locker/object/pword.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String col_id = 'id';
const String col_user = 'username';
const String col_pass = 'password';
const String col_site = 'site';
const String col_timestamp = 'timestamp';

class Passheper {

  Passheper._const();
  static final Passheper instance = Passheper._const();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  static const int    ver = 1;
  static const String dbname = 'pass_word.db';
  static const String table = 'passtable';


  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, dbname);
    return await openDatabase(path, onCreate: _onCreate, version: ver);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        ''' 
       CREATE TABLE $table
       (
           $col_id INTEGER PRIMARY KEY,
           $col_user TEXT,
           $col_pass TEXT,
           $col_site TEXT,
           $col_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
       )
       '''
    );
  }

  Future<List<Pword>> getList() async {
    Database db = await instance.database;
    var data = await db.query(table, /*orderBy: col_timestamp*/);
    List<Pword> pList = data.isNotEmpty ? data.map((c) => Pword.fromMap(c)).toList() : [];
    return pList;
  }

  Future<int> add(Pword pword) async {
    Database db = await instance.database;
    return await db.insert(table, pword.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$col_id = ?', whereArgs: [id]);
  }

  Future<int> update(Pword pword) async {
    Database db = await instance.database;
    return await db.update(table, pword.toMap(), where: "$col_id = ?", whereArgs: [pword.id]);
  }

  Future<int> uppass(int id,String pass) async {
    Database db = await instance.database;
    return await db.update(
        table,
        {col_pass : pass},
        where: "$col_id = ?",
        whereArgs: [id]
    );
  }

  /*Future<List<e>> getcuslist(int indx) async {
    Database db = await instance.database;
    var casfers = await db.query(table, orderBy: col_e);
    List<e> data = casfers.isNotEmpty ? casfers.map((c) => e0.fromMap(c)).toList() : [];
    List<e> elist = [];
    data.forEach((element) {
      if(element.indx == indx)
        e1list.add(element);
    });
    return e2list;
  }*/

}