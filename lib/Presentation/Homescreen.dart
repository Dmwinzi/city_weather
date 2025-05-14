import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../Utils/Screenutils.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? _selectedCity = 'Nairobi';
  final List<String> _cities = ['Nairobi', 'Mombasa', 'Kisumu', 'Nakuru'];

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final fontSizeTitle = ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.045 : 0.06);
    final fontSizeSubtitle = ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.025 : 0.035);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final forecastCards = List.generate(5, (index) {
            final day = DateFormat('EEEE').format(
              DateTime.now().add(Duration(days: index + 1)),
            );
            final forecastTemp = '26°C';
            final condition = 'Cloudy';

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
                          child: Lottie.asset("assets/images/suncloud.json", fit: BoxFit.contain),
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
          });

          final forecastWidget = isLandscape
              ? SingleChildScrollView(
            child: Column(children: forecastCards),
          )
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: forecastCards),
          );

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
              const SizedBox(height: 10),
              Center(
                child: Column(
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
                      '27°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtils.getAdaptiveFontSize(context, factor: isLandscape ? 0.06 : 0.08),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: ListView.builder(
            itemCount: _cities.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.place, color: Colors.white),
                title: Text(
                  _cities[index],
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    _selectedCity = _cities[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }


}
