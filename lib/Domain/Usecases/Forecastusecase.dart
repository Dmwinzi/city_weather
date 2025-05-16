import 'package:city_weather/Domain/Repository/Forecastrepository.dart';

import '../../Data/Models/Currentweathermodel.dart';
import '../../Data/Models/Forecastmodel.dart';

class Forecastusecase{

  final Forecastrepository forecastrepository;

  Forecastusecase(this.forecastrepository);


  Future<List<Forecast>> getForecast(String city){
     return forecastrepository.getForecast(city);
  }

  Future<CurrentWeather> getCurrentWeather(String city){
     return forecastrepository.getCurrentWeather(city);
  }


}