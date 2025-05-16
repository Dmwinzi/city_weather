import 'package:city_weather/Data/Models/Forecastmodel.dart';
import 'package:city_weather/Presentation/Homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'DI/Locator.dart';
import 'Data/Models/Currentweathermodel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Setup();
  await Hive.initFlutter();
  Hive.registerAdapter(ForecastAdapter());
  Hive.registerAdapter(CurrentWeatherAdapter());
  await Hive.openBox<Forecast>('forecastBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}

