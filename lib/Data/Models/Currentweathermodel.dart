import 'package:hive/hive.dart';

part 'Currentweathermodel.g.dart';

@HiveType(typeId: 2)
class CurrentWeather {
  @HiveField(0)
  final double lon;

  @HiveField(1)
  final double lat;

  @HiveField(2)
  final int weatherId;

  @HiveField(3)
  final String main;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String icon;

  @HiveField(6)
  final double temp;

  @HiveField(7)
  final double feelsLike;

  @HiveField(8)
  final double tempMin;

  @HiveField(9)
  final double tempMax;

  @HiveField(10)
  final int pressure;

  @HiveField(11)
  final int humidity;

  @HiveField(12)
  final int visibility;

  @HiveField(13)
  final double windSpeed;

  @HiveField(14)
  final int windDeg;

  @HiveField(15)
  final double? windGust;

  @HiveField(16)
  final double? rain1h;

  @HiveField(17)
  final int cloudsAll;

  @HiveField(18)
  final int dt;

  @HiveField(19)
  final String country;

  @HiveField(20)
  final int sunrise;

  @HiveField(21)
  final int sunset;

  @HiveField(22)
  final int timezone;

  @HiveField(23)
  final int id;

  @HiveField(24)
  final String name;

  @HiveField(25)
  final int cod;

  CurrentWeather({
    required this.lon,
    required this.lat,
    required this.weatherId,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    this.rain1h,
    required this.cloudsAll,
    required this.dt,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lon: (json['coord']['lon'] as num).toDouble(),
      lat: (json['coord']['lat'] as num).toDouble(),
      weatherId: json['weather'][0]['id'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDeg: json['wind']['deg'],
      windGust: json['wind']['gust'] != null ? (json['wind']['gust'] as num).toDouble() : null,
      rain1h: json['rain'] != null ? (json['rain']['1h'] as num?)?.toDouble() : null,
      cloudsAll: json['clouds']['all'],
      dt: json['dt'],
      country: json['sys']['country'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': {'lon': lon, 'lat': lat},
      'weather': [
        {
          'id': weatherId,
          'main': main,
          'description': description,
          'icon': icon,
        }
      ],
      'main': {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      },
      'visibility': visibility,
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
        if (windGust != null) 'gust': windGust,
      },
      'rain': rain1h != null ? {'1h': rain1h} : null,
      'clouds': {'all': cloudsAll},
      'dt': dt,
      'sys': {
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      },
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }
}
