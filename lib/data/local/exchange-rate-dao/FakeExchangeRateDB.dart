import 'package:currency_converter/data/local/Database.mocks.dart';
import 'package:currency_converter/data/local/StringConstants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

class FakeExchangeRateDB {
  @GenerateMocks([Database])
  static Database getInstance() {
    final db = MockDatabase();
    when(db.query(StringConstants.tableName)).thenAnswer((_) async => [
          {
            '${StringConstants.id}': 1,
            '${StringConstants.from_currency_code}': 'USD',
            '${StringConstants.from_currency_name}': 'United States Dollar',
            '${StringConstants.to_currency_code}': 'JPY',
            '${StringConstants.to_currency_name}': 'Japanese Yen',
            '${StringConstants.exchange_rate}': 100.003
          },
          {
            '${StringConstants.id}': 2,
            '${StringConstants.from_currency_code}': 'CNY',
            '${StringConstants.from_currency_name}': 'Chinese Yuan',
            '${StringConstants.to_currency_code}': 'EUR',
            '${StringConstants.to_currency_name}': 'Euro',
            '${StringConstants.exchange_rate}': 0.13
          }
        ]);
    return db;
  }
}
