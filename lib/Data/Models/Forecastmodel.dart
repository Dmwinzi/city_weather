import 'package:hive/hive.dart';

part 'Forecastmodel.g.dart';

@HiveType(typeId: 1)
class Forecast {
  @HiveField(0)
  final double temp;

  @HiveField(1)
  final double feelsLike;

  @HiveField(2)
  final double tempMin;

  @HiveField(3)
  final double tempMax;

  @HiveField(4)
  final int humidity;

  @HiveField(5)
  final double pressure;

  @HiveField(6)
  final double seaLevel;

  @HiveField(7)
  final double groundLevel;

  @HiveField(8)
  final double tempKf;

  @HiveField(9)
  final int weatherId;

  @HiveField(10)
  final String main;

  @HiveField(11)
  final String description;

  @HiveField(12)
  final String icon;

  @HiveField(13)
  final int clouds;

  @HiveField(14)
  final double windSpeed;

  @HiveField(15)
  final int windDeg;

  @HiveField(16)
  final double windGust;

  @HiveField(17)
  final int visibility;

  @HiveField(18)
  final double pop;

  @HiveField(19)
  final double rainVolume;

  @HiveField(20)
  final String pod;

  @HiveField(21)
  final String dateTime;

  @HiveField(22)
  final int dt;

  @HiveField(23)
  final DateTime lastUpdated;

  Forecast({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.seaLevel,
    required this.groundLevel,
    required this.tempKf,
    required this.weatherId,
    required this.main,
    required this.description,
    required this.icon,
    required this.clouds,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.visibility,
    required this.pop,
    required this.rainVolume,
    required this.pod,
    required this.dateTime,
    required this.dt,
    required this.lastUpdated,
  });

  factory Forecast.fromJson(Map<String, dynamic> json, {required DateTime lastUpdated}) {
    return Forecast(
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'],
      pressure: (json['main']['pressure'] as num).toDouble(),
      seaLevel: (json['main']['sea_level'] as num?)?.toDouble() ?? 0.0,
      groundLevel: (json['main']['grnd_level'] as num?)?.toDouble() ?? 0.0,
      tempKf: (json['main']['temp_kf'] as num?)?.toDouble() ?? 0.0,
      weatherId: json['weather'][0]['id'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      clouds: json['clouds']['all'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDeg: json['wind']['deg'],
      windGust: (json['wind']['gust'] as num?)?.toDouble() ?? 0.0,
      visibility: json['visibility'],
      pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
      rainVolume: (json['rain']?['3h'] as num?)?.toDouble() ?? 0.0,
      pod: json['sys']['pod'],
      dateTime: json['dt_txt'],
      dt: json['dt'],
      lastUpdated: lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': groundLevel,
        'humidity': humidity,
        'temp_kf': tempKf,
      },
      'weather': [
        {
          'id': weatherId,
          'main': main,
          'description': description,
          'icon': icon,
        }
      ],
      'clouds': {'all': clouds},
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
        'gust': windGust,
      },
      'visibility': visibility,
      'pop': pop,
      'rain': {'3h': rainVolume},
      'sys': {'pod': pod},
      'dt_txt': dateTime,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
