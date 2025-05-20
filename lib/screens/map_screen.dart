import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travel_app/generated/l10n.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Map<String, dynamic>? weatherData;
  final cityKeys = ["Bali", "Santorini", "Kyoto", "Astana", "Karaganda", "New York"];

  Future<Map<String, dynamic>> fetchWeather() async {
    const apiKey = '22fc7c0bf35b45dbb8584648251504';
    Map<String, dynamic> result = {};

    for (var city in cityKeys) {
      final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no');
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          result[city] = {
            "temp": data["current"]["temp_c"].round(),
            "description": data["current"]["condition"]["text"]
          };
        } else {
          result[city] = {"temp": "?", "description": "Failed"};
        }
      } catch (e) {
        result[city] = {"temp": "?", "description": "Error"};
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    fetchWeather().then((data) {
      setState(() {
        weatherData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final localizedNames = {
      "Bali": s.cityBali,
      "Santorini": s.citySantorini,
      "Kyoto": s.cityKyoto,
      "Astana": s.cityAstana,
      "Karaganda": s.cityKaraganda,
      "New York": s.cityNewYork,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(s.mapTitle),
      ),
      body: weatherData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (var city in cityKeys)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.cloud, size: 32),
                title: Text(
                  localizedNames[city] ?? city,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  s.temperature(
                    weatherData![city]["temp"].toString(),
                    weatherData![city]["description"],
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
