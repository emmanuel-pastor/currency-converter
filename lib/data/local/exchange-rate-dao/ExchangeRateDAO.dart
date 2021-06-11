import 'package:currency_converter/data/local/DBService.dart';
import 'package:currency_converter/data/local/StringConstants.dart';
import 'package:currency_converter/data/local/exchange-rate-dao/FakeExchangeRateDB.dart';
import 'package:currency_converter/data/local/models/ExchangeRateEntity.dart';
import 'package:sqflite/sqflite.dart';

class ExchangeRateDAO {
  Database? _db;

  Future<Database> _getDB() async {
    return this._db == null ? DBService.getDBInstance() : Future.value(this._db!);
  }

  ExchangeRateDAO(this._db);

  factory ExchangeRateDAO.defaultInstance() {
    return ExchangeRateDAO(null);
  }

  factory ExchangeRateDAO.fake() {
    final db = FakeExchangeRateDB.getInstance();
    return ExchangeRateDAO(db);
  }

  Future<int> insert(ExchangeRateEntity entity) async {
    final db = await _getDB();
    return await db.insert(
      StringConstants.tableName,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ExchangeRateEntity>> getAllExchangeRates() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(StringConstants.tableName);

    return List.generate(maps.length, (i) {
      return ExchangeRateEntity.fromMap(maps[i]);
    });
  }

  Future<ExchangeRateEntity> getExchangeRate(
      {required String fromCurrencyCode, required String toCurrencyCode}) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(StringConstants.tableName,
        where:
        '${StringConstants.from_currency_code} = ? and ${StringConstants.to_currency_code} = ?',
        whereArgs: [fromCurrencyCode, toCurrencyCode],
        limit: 1);

    return ExchangeRateEntity.fromMap(maps.first);
  }
}
