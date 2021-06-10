import 'package:currency_converter/data/remote/APIService.dart';
import 'package:currency_converter/data/remote/http.Client.mocks.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class FakeExchangeRateAPIService {
  static APIService getInstance() {
    final client = MockClient();
    when(client.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(
        '{ "Realtime Currency Exchange Rate": { "1. From_Currency Code": "USD", "2. From_Currency Name": "United States Dollar", "3. To_Currency Code": "JPY", "4. To_Currency Name": "Japanese Yen", "5. Exchange Rate": "130.11100000", "6. Last Refreshed": "2021-06-04 10:11:50", "7. Time Zone": "UTC", "8. Bid Price": "130.10560000", "9. Ask Price": "110.11410000" } }',
        200));
    return APIService(client);
  }
}
