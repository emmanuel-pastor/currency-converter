import 'package:currency_converter/data/local/exchange-rate-dao/ExchangeRateDAO.dart';
import 'package:currency_converter/data/remote/exchange-rate-endpoint/ExchangeRateEndpoint.dart';
import 'package:currency_converter/domain/features/conversion/UseCases.dart';
import 'package:currency_converter/domain/repositories/ExchangeRateRepository.dart';
import 'package:currency_converter/presentation/home/HomeViewModel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // ExchangeRate related dependencies
  locator.registerLazySingleton<ExchangeRateEndpoint>(() => ExchangeRateEndpoint.defaultInstance());
  locator.registerLazySingleton<ExchangeRateDAO>(() => ExchangeRateDAO.defaultInstance());
  locator.registerLazySingleton<ExchangeRateRepository>(
      () => ExchangeRateRepository(locator<ExchangeRateDAO>(), locator<ExchangeRateEndpoint>()));
  locator.registerFactory<ConversionUseCase>(
      () => ConversionUseCase(locator<ExchangeRateRepository>()));
  locator.registerLazySingleton<HomeViewModel>(
      () => HomeViewModel(locator<ConversionUseCase>()));
}
