import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../DI/Locator.dart';
import '../../Data/Models/Currentweathermodel.dart';
import '../../Data/Models/Forecastmodel.dart';
import '../../Domain/Usecases/Forecastusecase.dart';

class ForecastViewModel extends GetxController {

  final Forecastusecase forecastUsecase = locator<Forecastusecase>();

  var forecasts = <Forecast>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var lastUpdated = ''.obs;
  var currentWeather = Rxn<CurrentWeather>();

  Future<void> fetchForecast(String city) async {
    isLoading.value = true;
    error.value = '';
    lastUpdated.value = '';

    try {
      final data = await forecastUsecase.getForecast(city);
      forecasts.value = data;

      if (data.isNotEmpty) {
        final date = data.first.lastUpdated;
        lastUpdated.value = 'Last updated: ${DateFormat('yyyy-MM-dd HH:mm').format(date)}';
      } else {
        lastUpdated.value = 'No forecast data available';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCurrentWeather(String city) async {
    try {
      final current = await forecastUsecase.getCurrentWeather(city);
      currentWeather.value = current;
    } catch (e) {
      error.value = e.toString();
    }
  }

}
