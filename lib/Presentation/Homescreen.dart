import 'dart:async';
import 'dart:ui';
import 'package:city_weather/Presentation/Widgets/Citysearch.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../DI/Locator.dart';
import '../Domain/Usecases/Forecastusecase.dart';
import '../Utils/FilterDailyForecastinterval.dart';
import '../Utils/Lottieconditions.dart';
import '../Utils/Screenutils.dart';
import '../Utils/UsercentredError.dart';
import 'Viewmodel/Forecastviewmodel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? _selectedCity = 'Nairobi';
  final List<String> _cities = [
    'Nairobi', 'London', 'New York', 'Tokyo', 'Paris',
    'Sydney', 'Toronto', 'Berlin', 'Cape Town', 'Mumbai',
  ];

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final viewModel = Get.put(ForecastViewModel());

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('You are offline'),
            duration: Duration(seconds: 10),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Back online'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    });
    viewModel.fetchCurrentWeather(_selectedCity ?? "Nairobi");
    viewModel.fetchForecast(_selectedCity ?? "Nairobi");
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final fontSizeTitle = ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.045 : 0.06);
    final fontSizeSubtitle = ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.025 : 0.035);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {

          final forecastWidget = Obx(() {
            if (viewModel.isLoading.value) {
              return const Center(child: CircularProgressIndicator(color: Colors.white,));
            }
            if (viewModel.error.isNotEmpty) {
              return Center(child: Text('Error: ${viewModel.error.value}'));
            }
            if (viewModel.forecasts.isEmpty) {
              return const Center(child: Text('No forecast data'));
            }

            // Filter forecasts to only one per day closest to now
            final filteredForecasts = getDailyForecastsClosestToNow(viewModel.forecasts);

            final forecastCards = List.generate(
              filteredForecasts.length,
                  (index) {
                final forecast = filteredForecasts[index];
                final day = DateFormat('EEEE').format(DateTime.parse(forecast.dateTime));
                final forecastTemp = '${forecast.temp.round()}°C';
                final condition = forecast.main;

                return Container(
                  margin: const EdgeInsets.all(8),
                  width: isLandscape ? 100 : constraints.maxWidth * 0.35,
                  height: isLandscape ? 130 : null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Lottie.asset(
                                getLottieForCondition(forecast.main),
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(day, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text(forecastTemp, style: const TextStyle(color: Colors.white, fontSize: 14)),
                            Text(condition, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

            return isLandscape
                ? SingleChildScrollView(child: Column(children: forecastCards))
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: forecastCards),
            );
          });

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _showCityPicker(context),
                    child: Row(
                      children: [
                        const Icon(Icons.place_rounded, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          _selectedCity ?? "Select City",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "About Today",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.grey,
                  fontSize: fontSizeTitle,
                ),
              ),
              if (viewModel.lastUpdated.value != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '${viewModel.lastUpdated.value}',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 10),
              Center(
                child: Obx(() {
                  final current = viewModel.currentWeather.value;
                  final error = viewModel.error.value;

                  if (error.isNotEmpty) {
                    print("CHECK"+error);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            getUserFriendlyErrorMessage(error),
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.redAccent,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      viewModel.error.value = '';
                    });
                  }

                  if (current == null) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: isLandscape ? constraints.maxWidth * 0.4 : double.infinity,
                          height: isLandscape ? constraints.maxHeight * 0.4 : constraints.maxHeight * 0.25,
                          child: Lottie.asset('assets/images/suncloud.json'),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          DateFormat('EEEE, dd MMMM').format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeSubtitle,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '--°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.06 : 0.08),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: isLandscape ? constraints.maxWidth * 0.4 : double.infinity,
                        height: isLandscape ? constraints.maxHeight * 0.4 : constraints.maxHeight * 0.25,
                        child: Lottie.asset(getLottieForCondition(current.main)),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        DateFormat('EEEE, dd MMMM').format(DateTime.now()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeSubtitle,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${current.temp.round()}°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.06 : 0.08),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }),
              ),

              // Center(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       SizedBox(
              //         width: isLandscape ? constraints.maxWidth * 0.4 : double.infinity,
              //         height: isLandscape ? constraints.maxHeight * 0.4 : constraints.maxHeight * 0.25,
              //         child: Lottie.asset('assets/images/suncloud.json'),
              //       ),
              //       const SizedBox(height: 20),
              //       Text(
              //         DateFormat('EEEE, dd MMMM').format(DateTime.now()),
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: fontSizeSubtitle,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       const SizedBox(height: 10),
              //       Text(
              //         '27°C',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.06 : 0.08),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          );

          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF121212),
                        Color(0xFF181818),
                        Color(0xFF1E1E1E),
                        Color(0xFF000000),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: isLandscape
                          ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(child: content),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: forecastWidget,
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          Expanded(child: SingleChildScrollView(child: content)),
                          SizedBox(height: 200, child: forecastWidget),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCityPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121212),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CitySearchSheet(
          cities: _cities,
          onCitySelected: (selectedCity) {
            setState(() {
              _selectedCity = selectedCity;
            });

            viewModel.fetchCurrentWeather(selectedCity);
            viewModel.fetchForecast(selectedCity);
            Navigator.pop(context);
          },
        );
      },
    );
  }




}
