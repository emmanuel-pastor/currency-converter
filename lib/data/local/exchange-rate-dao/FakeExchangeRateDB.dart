import 'package:currency_converter/data/local/Database.mocks.dart';
import 'package:currency_converter/data/local/StringConstants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

@GenerateMocks([Database])
class FakeExchangeRateDB {
  static Database getInstance() {
    final db = MockDatabase();

    final exchangeRate1 = {
      '${StringConstants.id}': 'USDJPY',
      '${StringConstants.from_currency_code}': 'USD',
      '${StringConstants.from_currency_name}': 'United States Dollar',
      '${StringConstants.to_currency_code}': 'JPY',
      '${StringConstants.to_currency_name}': 'Japanese Yen',
      '${StringConstants.rate}': 100.003
    };
    final exchangeRate2 = {
      '${StringConstants.id}': 'CNYEUR',
      '${StringConstants.from_currency_code}': 'CNY',
      '${StringConstants.from_currency_name}': 'Chinese Yuan',
      '${StringConstants.to_currency_code}': 'EUR',
      '${StringConstants.to_currency_name}': 'Euro',
      '${StringConstants.rate}': 0.13
    };

    when(db.query(StringConstants.tableName))
        .thenAnswer((_) async => [exchangeRate1, exchangeRate2]);

    when(db.query(StringConstants.tableName, where: anyNamed('where'), whereArgs: anyNamed('whereArgs'), limit: anyNamed('limit')))
        .thenAnswer((_) async => [exchangeRate1]);

    when(db.insert(StringConstants.tableName, any,
            conflictAlgorithm: anyNamed('conflictAlgorithm')))
        .thenAnswer((_) async => 0);
    return db;
  }
}
