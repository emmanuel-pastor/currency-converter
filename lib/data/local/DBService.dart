import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:currency_converter/data/local/DBStrings.dart';

class DBService {
  static Future<Database> getDBInstance() async {
    final database = openDatabase(
      join(await getDatabasesPath(), DBStrings.dbName),

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
      'CREATE TABLE ${DBStrings.tableName}(${DBStrings.id} TEXT PRIMARY KEY NOT NULL, ${DBStrings.from_currency_code} TEXT, ${DBStrings.from_currency_name} TEXT, ${DBStrings.to_currency_code} TEXT, ${DBStrings.to_currency_name} TEXT, ${DBStrings.rate} FLOAT)',
    );
  }
}
