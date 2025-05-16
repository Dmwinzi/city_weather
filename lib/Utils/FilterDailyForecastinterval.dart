import 'package:intl/intl.dart';

import '../Data/Models/Forecastmodel.dart';

List<Forecast> getDailyForecastsClosestToNow(List<Forecast> forecasts) {
  final now = DateTime.now();
  final Map<String, Forecast> closestByDay = {};

  for (final forecast in forecasts) {
    final forecastDate = DateTime.parse(forecast.dateTime);
    final dayKey = DateFormat('yyyy-MM-dd').format(forecastDate);

    final currentclosest = closestByDay[dayKey];
    if (currentclosest == null) {
      closestByDay[dayKey] = forecast;
    } else {
      final currentClosestDate = DateTime.parse(currentclosest.dateTime);
      final currentDiff = (currentClosestDate.difference(now)).abs();
      final newDiff = (forecastDate.difference(now)).abs();

      if (newDiff < currentDiff) {
        closestByDay[dayKey] = forecast;
      }
    }
  }
  final filteredList = closestByDay.values.toList();
  filteredList.sort((a, b) => DateTime.parse(a.dateTime).compareTo(DateTime.parse(b.dateTime)));

  return filteredList;
}
