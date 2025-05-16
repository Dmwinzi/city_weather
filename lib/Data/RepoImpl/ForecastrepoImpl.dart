import 'package:city_weather/Data/Models/Forecastmodel.dart';
import 'package:city_weather/Domain/Repository/Forecastrepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

import '../../Utils/Connectivity.dart';
import '../Models/Currentweathermodel.dart';

class ForecastrepoImpl extends Forecastrepository{

  final Dio dio;
  final Future<bool> Function() connectivityChecker;

  ForecastrepoImpl(this.dio, {this.connectivityChecker = checkConnectivity});

  @override
  Future<List<Forecast>> getForecast(String city) async {
    bool isConnected = await connectivityChecker();

    if (isConnected) {
      final response = await dio.get('/forecast', queryParameters: {
        'q': city,
        'appid': dotenv.env['API_KEY'],
        'units': 'metric',
      });

      if (response.statusCode == 200) {
        final DateTime now = DateTime.now();

        List<Forecast> forecastData = (response.data['list'] as List)
            .map((data) => Forecast.fromJson(data, lastUpdated: now))
            .toList();

        Box<Forecast> forecastBox = await Hive.openBox<Forecast>('forecastBox');
        forecastBox.clear();
        forecastBox.addAll(forecastData);

        return forecastData;
      } else {
        throw Exception("Failed to load weather data.");
      }
    } else {
      Box<Forecast> forecastBox = await Hive.openBox<Forecast>('forecastBox');
      if (forecastBox.isEmpty) {
        throw Exception("No data available and no internet connection.");
      } else {
        return forecastBox.values.toList();
      }
    }
  }

  @override
  Future<CurrentWeather> getCurrentWeather(String city) async {
    bool isConnected = await connectivityChecker();

    if (isConnected) {
      final response = await dio.get('/weather', queryParameters: {
        'q': city,
        'appid': dotenv.env['API_KEY'],
        'units': 'metric',
      });

      if (response.statusCode == 200) {
        final currentWeather = CurrentWeather.fromJson(response.data);

        final box = await Hive.openBox<CurrentWeather>('currentWeatherBox');
        await box.clear();
        await box.add(currentWeather);

        return currentWeather;
      } else {
        throw Exception('Failed to load current weather.');
      }
    } else {
      final box = await Hive.openBox<CurrentWeather>('currentWeatherBox');
      if (box.isEmpty) {
        throw Exception("No data available and no internet connection.");
      } else {
        return box.values.first;
      }
    }
  }



}