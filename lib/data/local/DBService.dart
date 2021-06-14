import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:currency_converter/data/local/StringConstants.dart';

class DBService {
  static Future<Database> getDBInstance() async {
    final database = openDatabase(
      join(await getDatabasesPath(), StringConstants.dbName),

      onCreate: (db, version) {
        return _createTables(db);
      },
      version: 1,
    );
    return database;
  }

  static Future<void> _createTables(Database db) async {
    FutureGroup futureGroup = FutureGroup();
    futureGroup.add(_createExchangeRateTable(db));
    futureGroup.close();
    return futureGroup.future.then((_) => null);
  }

  static Future<void> _createExchangeRateTable(Database db) async {
    return db.execute(
      'CREATE TABLE ${StringConstants.tableName}(${StringConstants.id} TEXT PRIMARY KEY NOT NULL, ${StringConstants.from_currency_code} TEXT, ${StringConstants.from_currency_name} TEXT, ${StringConstants.to_currency_code} TEXT, ${StringConstants.to_currency_name} TEXT, ${StringConstants.rate} FLOAT)',
    );
  }
}
