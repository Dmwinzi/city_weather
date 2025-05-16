// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Forecastmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastAdapter extends TypeAdapter<Forecast> {
  @override
  final int typeId = 1;

  @override
  Forecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forecast(
      temp: fields[0] as double,
      feelsLike: fields[1] as double,
      tempMin: fields[2] as double,
      tempMax: fields[3] as double,
      humidity: fields[4] as int,
      pressure: fields[5] as double,
      seaLevel: fields[6] as double,
      groundLevel: fields[7] as double,
      tempKf: fields[8] as double,
      weatherId: fields[9] as int,
      main: fields[10] as String,
      description: fields[11] as String,
      icon: fields[12] as String,
      clouds: fields[13] as int,
      windSpeed: fields[14] as double,
      windDeg: fields[15] as int,
      windGust: fields[16] as double,
      visibility: fields[17] as int,
      pop: fields[18] as double,
      rainVolume: fields[19] as double,
      pod: fields[20] as String,
      dateTime: fields[21] as String,
      dt: fields[22] as int,
      lastUpdated: fields[23] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Forecast obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.temp)
      ..writeByte(1)
      ..write(obj.feelsLike)
      ..writeByte(2)
      ..write(obj.tempMin)
      ..writeByte(3)
      ..write(obj.tempMax)
      ..writeByte(4)
      ..write(obj.humidity)
      ..writeByte(5)
      ..write(obj.pressure)
      ..writeByte(6)
      ..write(obj.seaLevel)
      ..writeByte(7)
      ..write(obj.groundLevel)
      ..writeByte(8)
      ..write(obj.tempKf)
      ..writeByte(9)
      ..write(obj.weatherId)
      ..writeByte(10)
      ..write(obj.main)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.icon)
      ..writeByte(13)
      ..write(obj.clouds)
      ..writeByte(14)
      ..write(obj.windSpeed)
      ..writeByte(15)
      ..write(obj.windDeg)
      ..writeByte(16)
      ..write(obj.windGust)
      ..writeByte(17)
      ..write(obj.visibility)
      ..writeByte(18)
      ..write(obj.pop)
      ..writeByte(19)
      ..write(obj.rainVolume)
      ..writeByte(20)
      ..write(obj.pod)
      ..writeByte(21)
      ..write(obj.dateTime)
      ..writeByte(22)
      ..write(obj.dt)
      ..writeByte(23)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
