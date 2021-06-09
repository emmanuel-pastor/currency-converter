import 'package:currency_converter/data/local/StringConstants.dart';
import 'package:currency_converter/data/local/models/ExchangeRateEntity.dart';
import 'package:sqflite/sqflite.dart';

class ExchangeRateDAO {
  late Database _db;

  ExchangeRateDAO(this._db);

  Future<void> insert(ExchangeRateEntity entity) async {
    await _db.insert(
      StringConstants.tableName,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ExchangeRateEntity>> getAllExchangeRates() async {
    final List<Map<String, dynamic>> maps = await _db.query(StringConstants.tableName);

    return List.generate(maps.length, (i) {
      return ExchangeRateEntity.fromMap(maps[i]);
    });
  }
}
