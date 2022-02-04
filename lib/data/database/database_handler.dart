import 'package:majoomovie/data/models/user.dart';
import 'package:majoomovie/data/provider/auth_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  AuthenProvider authenProvider = AuthenProvider.instance;
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print(path);
    return openDatabase(join(path, 'majoodata.db'),
        onCreate: (database, version) async {
      await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL)");
    }, version: 2);
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<List<User>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getLogin(String email, String password) async {
    final db = await initializeDB();
    var res = await db.query("users",
        where: "`email` LIKE '$email' AND `password` LIKE '$password'");
    if (res.isNotEmpty) {
      authenProvider.statusLogin = true;
      return User.fromMap(res.first);
    } else {
      authenProvider.statusLogin = false;
      print("user not found!");
    }
    return null;
  }

  Future<User?> getLogout(String email) async {
    final db = await initializeDB();
    var res = await db.query('users', where: "`email` LIKE '$email'");
    if (res.isNotEmpty) {
      authenProvider.statusLogin = false;
    } else {
      print("network error");
    }
    return null;
  }
}
