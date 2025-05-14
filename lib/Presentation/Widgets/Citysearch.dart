import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitySearchSheet extends StatefulWidget {
  final List<String> cities;
  final Function(String) onCitySelected;

  const CitySearchSheet({
    Key? key,
    required this.cities,
    required this.onCitySelected,
  }) : super(key: key);

  @override
  State<CitySearchSheet> createState() => _CitySearchSheetState();
}

class _CitySearchSheetState extends State<CitySearchSheet> {
  late List<String> _filteredCities;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCities = widget.cities;
  }

  void _filterCities(String query) {
    setState(() {
      _filteredCities = widget.cities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _controller,
                onChanged: _filterCities,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.white54),
                  hintText: 'Search city...',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredCities.isEmpty
                  ? const Center(
                child: Text(
                  'No matching cities found.',
                  style: TextStyle(color: Colors.white70),
                ),
              )
                  : ListView.separated(
                itemCount: _filteredCities.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white12),
                itemBuilder: (context, index) {
                  final city = _filteredCities[index];
                  return ListTile(
                    leading: const Icon(Icons.place, color: Colors.white),
                    title: Text(
                      city,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () => widget.onCitySelected(city),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
