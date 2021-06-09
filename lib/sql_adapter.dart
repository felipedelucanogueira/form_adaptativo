import 'package:form_adaptativo/internal_storage.dart';
import 'package:form_adaptativo/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLAdapter extends InternalStorageAdapter {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    print(_database?.path);
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(path, onCreate: (db, version) {
      return db.execute('CREATE TABLE Users(name TEXT, surname TEXT)');
    }, version: 1);
  }

  @override
  Future<String> getFullName() async {
    final Database db = await database;
    var response = await db.query('Users',
        columns: ['rowid', 'name', 'surname'],);

    if (response.isNotEmpty) {
      final user = User.fromMap(response.last);
      return user.rowid.toString() + ' ' + user.name + ' ' + user.surname;
    } else {
      return 'Usuario não encontrado';
    }
  }

  @override
  void saveUser(String name, String surname) async {
    final Database db = await database;
    var user = {'name': name, 'surname': surname};
    await db.insert('Users', user);
    print('Usuario no Banco de Dados');
  }

  void deleteUser(String name, String surname) async {
    final Database db = await database;
    var response = await db.query('Users',
      columns: ['rowid', 'name', 'surname'],);

    if (response.isNotEmpty) {
      final user = User.fromMap(response.last);
      await db.delete('Users', where: 'rowid = ?', whereArgs: [user.rowid]);
    }
  }

  @override
  Future<String?> getName() async{
    final Database db = await database;
    var response = await db.query('Users',
      columns: ['rowid', 'name', 'surname'],);

    if (response.isNotEmpty) {
      final user = User.fromMap(response.last);
      return user.rowid.toString() + user.name;
    } else {
      return '';
    }
  }

  @override
  Future<String?> getSurname() async{

    final Database db = await database;
    var response = await db.query('Users',
      columns: ['rowid', 'name', 'surname'],);

    if (response.isNotEmpty) {
      final user = User.fromMap(response.last);
      return user.surname;
    } else {
      return '';
    }

  }
}
