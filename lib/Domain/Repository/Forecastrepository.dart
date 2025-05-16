import '../../Data/Models/Currentweathermodel.dart';
import '../../Data/Models/Forecastmodel.dart';

abstract class Forecastrepository{

  Future<List<Forecast>> getForecast(String city);

  Future<CurrentWeather> getCurrentWeather(String city);

}