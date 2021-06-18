import 'package:currency_converter/data/local/Database.mocks.dart';
import 'package:currency_converter/data/local/DBStrings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

@GenerateMocks([Database])
class FakeExchangeRateDB {
  static Database getInstance() {
    final db = MockDatabase();

    final exchangeRate1 = {
      '${DBStrings.id}': 'USDJPY',
      '${DBStrings.from_currency_code}': 'USD',
      '${DBStrings.from_currency_name}': 'United States Dollar',
      '${DBStrings.to_currency_code}': 'JPY',
      '${DBStrings.to_currency_name}': 'Japanese Yen',
      '${DBStrings.rate}': 100.003
    };
    final exchangeRate2 = {
      '${DBStrings.id}': 'CNYEUR',
      '${DBStrings.from_currency_code}': 'CNY',
      '${DBStrings.from_currency_name}': 'Chinese Yuan',
      '${DBStrings.to_currency_code}': 'EUR',
      '${DBStrings.to_currency_name}': 'Euro',
      '${DBStrings.rate}': 0.13
    };

    when(db.query(DBStrings.tableName))
        .thenAnswer((_) async => [exchangeRate1, exchangeRate2]);

    when(db.query(DBStrings.tableName, where: anyNamed('where'), whereArgs: anyNamed('whereArgs'), limit: anyNamed('limit')))
        .thenAnswer((_) async => [exchangeRate1]);

    when(db.insert(DBStrings.tableName, any,
            conflictAlgorithm: anyNamed('conflictAlgorithm')))
        .thenAnswer((_) async => 0);
    return db;
  }
}
