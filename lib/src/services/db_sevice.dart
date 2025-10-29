import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DBService {
static final DBService _instance = DBService._internal();
factory DBService() => _instance;
DBService._internal();


Database? _db;


Future<Database> get database async {
if (_db != null) return _db!;
_db = await _initDB();
return _db!;
}


Future<Database> _initDB() async {
final documentsDirectory = await getApplicationDocumentsDirectory();
final path = join(documentsDirectory.path, 'advanced_tracker.db');


return await openDatabase(path, version: 1, onCreate: _createDB);
}


Future<void> _createDB(Database db, int version) async {
await db.execute('''
CREATE TABLE sessions (
id INTEGER PRIMARY KEY AUTOINCREMENT,
session_id TEXT,
start_time TEXT,
end_time TEXT,
synced INTEGER
)
''');


await db.execute('''
CREATE TABLE locations (
id INTEGER PRIMARY KEY AUTOINCREMENT,
session_id TEXT,
latitude REAL,
longitude REAL,
accuracy REAL,
speed REAL,
timestamp TEXT,
synced INTEGER
)
''');
}


Future<int> insert(String table, Map<String, dynamic> values) async {
final db = await database;
return await db.insert(table, values);
}


Future<List<Map<String, dynamic>>> query(String table, {String? where, List<Object?>? whereArgs, String? orderBy}) async {
final db = await database;
return await db.query(table, where: where, whereArgs: whereArgs, orderBy: orderBy);
}


Future<int> update(String table, Map<String, dynamic> values, {String? where, List<Object?>? whereArgs}) async {
final db = await database;
return await db.update(table, values, where: where, whereArgs: whereArgs);
}


Future<int> delete(String table, {String? where, List<Object?>? whereArgs}) async {
final db = await database;
return await db.delete(table, where: where, whereArgs: whereArgs);
}
}