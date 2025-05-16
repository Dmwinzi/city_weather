import 'dart:io';
import 'package:city_weather/Data/RepoImpl/ForecastrepoImpl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart' as path;
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:city_weather/Data/Models/Forecastmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

// Mock Dio class
class MockDio extends Mock implements Dio {}

void main() {
  late ForecastrepoImpl apiService;
  late MockDio mockDio;
  late Box<Forecast> forecastBox;

  setUpAll(() async {
    final testDir = Directory(path.join(Directory.current.path, 'test_hive_data'));
    if (!testDir.existsSync()) {
      testDir.createSync(recursive: true);
    }
    Hive.init(testDir.path);
    Hive.registerAdapter(ForecastAdapter());
    await dotenv.load();
  });

  setUp(() async {
    mockDio = MockDio();

    apiService = ForecastrepoImpl(mockDio, connectivityChecker: () async => true);

    forecastBox = await Hive.openBox<Forecast>('forecastBox');
    await forecastBox.clear();
  });

  tearDown(() async {
    await forecastBox.clear();
    await forecastBox.close();
  });

  tearDownAll(() async {
    final testDir = Directory(path.join(Directory.current.path, 'test_hive_data'));
    if (testDir.existsSync()) {
      await testDir.delete(recursive: true);
    }
  });


  test('returns forecast data from Hive when offline', () async {
    await forecastBox.add(Forecast(
      dt: 1747764000,
      temp: 16.59,
      feelsLike: 16.73,
      tempMin: 16.59,
      tempMax: 16.59,
      pressure: 1016,
      seaLevel: 1016,
      groundLevel: 837,
      humidity: 93,
      tempKf: 0,
      weatherId: 500,
      main: 'Rain',
      description: 'light rain',
      icon: '10n',
      clouds: 78,
      windSpeed: 1.62,
      windDeg: 65,
      windGust: 2.99,
      visibility: 10000,
      pop: 0.41,
      rainVolume: 0.42,
      pod: 'n',
      dateTime: '2025-05-20 18:00:00',
      lastUpdated: DateTime.now(),
    ));

    // Simulate offline mode
    apiService = ForecastrepoImpl(mockDio, connectivityChecker: () async => false);

    final result = await apiService.getForecast('Nairobi');

    // Assert the correct result
    expect(result.length, 1);
    expect(result[0].temp, 16.59);
    expect(result[0].main, 'Rain');
    expect(result[0].description, 'light rain');
    expect(result[0].icon, '10n');
  });


  test('throws exception if offline and no cached data', () async {
    apiService = ForecastrepoImpl(mockDio, connectivityChecker: () async => false);
    await forecastBox.clear();

    expect(() async => await apiService.getForecast('Nairobi'), throwsException);
  });

}
