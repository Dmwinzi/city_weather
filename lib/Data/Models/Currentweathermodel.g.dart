// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Currentweathermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentWeatherAdapter extends TypeAdapter<CurrentWeather> {
  @override
  final int typeId = 2;

  @override
  CurrentWeather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentWeather(
      lon: fields[0] as double,
      lat: fields[1] as double,
      weatherId: fields[2] as int,
      main: fields[3] as String,
      description: fields[4] as String,
      icon: fields[5] as String,
      temp: fields[6] as double,
      feelsLike: fields[7] as double,
      tempMin: fields[8] as double,
      tempMax: fields[9] as double,
      pressure: fields[10] as int,
      humidity: fields[11] as int,
      visibility: fields[12] as int,
      windSpeed: fields[13] as double,
      windDeg: fields[14] as int,
      windGust: fields[15] as double?,
      rain1h: fields[16] as double?,
      cloudsAll: fields[17] as int,
      dt: fields[18] as int,
      country: fields[19] as String,
      sunrise: fields[20] as int,
      sunset: fields[21] as int,
      timezone: fields[22] as int,
      id: fields[23] as int,
      name: fields[24] as String,
      cod: fields[25] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeather obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.lon)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.weatherId)
      ..writeByte(3)
      ..write(obj.main)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.icon)
      ..writeByte(6)
      ..write(obj.temp)
      ..writeByte(7)
      ..write(obj.feelsLike)
      ..writeByte(8)
      ..write(obj.tempMin)
      ..writeByte(9)
      ..write(obj.tempMax)
      ..writeByte(10)
      ..write(obj.pressure)
      ..writeByte(11)
      ..write(obj.humidity)
      ..writeByte(12)
      ..write(obj.visibility)
      ..writeByte(13)
      ..write(obj.windSpeed)
      ..writeByte(14)
      ..write(obj.windDeg)
      ..writeByte(15)
      ..write(obj.windGust)
      ..writeByte(16)
      ..write(obj.rain1h)
      ..writeByte(17)
      ..write(obj.cloudsAll)
      ..writeByte(18)
      ..write(obj.dt)
      ..writeByte(19)
      ..write(obj.country)
      ..writeByte(20)
      ..write(obj.sunrise)
      ..writeByte(21)
      ..write(obj.sunset)
      ..writeByte(22)
      ..write(obj.timezone)
      ..writeByte(23)
      ..write(obj.id)
      ..writeByte(24)
      ..write(obj.name)
      ..writeByte(25)
      ..write(obj.cod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
