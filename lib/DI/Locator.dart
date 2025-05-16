import 'package:city_weather/Data/RepoImpl/ForecastrepoImpl.dart';
import 'package:get_it/get_it.dart';
import '../Data/Services/DioHandler.dart';
import '../Domain/Repository/Forecastrepository.dart';
import '../Domain/Usecases/Forecastusecase.dart';
import '../Presentation/Viewmodel/Forecastviewmodel.dart';

var locator = GetIt.instance;

Future<void> Setup() async{

  locator.registerLazySingleton(() => DioHandler.internal());
  locator.registerLazySingleton<Forecastrepository>(() => ForecastrepoImpl(locator<DioHandler>().dio));
  locator.registerLazySingleton<Forecastusecase>(() => Forecastusecase(locator<Forecastrepository>()));
  locator.registerFactory(() => ForecastViewModel());

}