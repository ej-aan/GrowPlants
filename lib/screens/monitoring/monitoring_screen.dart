import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:growplants/models/plant_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonitoringScreen extends StatefulWidget {
  @override
  _MonitoringScreenState createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  late Future<Map<String, dynamic>> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = getWeatherData(); // Fetch weather data
  }

  // Fetch weather data from OpenWeatherMap API
  Future<Map<String, dynamic>> getWeatherData() async {
    final apiKey = '8332a45935231c915e766a727c9a46d7';
    final city = 'Surabaya';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'weather': data['weather'][0]['main'],
        'temperature': data['main']['temp'].toString(),
        'humidity': data['main']['humidity'].toString(),
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Center(child: Text('User not logged in'));
    }

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('plants')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No plants available.'));
          }

          // Convert Firestore documents to Plant objects
          final plants = snapshot.data!.docs.map((doc) {
            return Plant.fromJson({
              ...doc.data() as Map<String, dynamic>,
              'id': doc.id,
            });
          }).toList();

          // Calculate category counts
          final categoryCounts = _getCategoryCounts(plants);
          final totalPlants = plants.length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weather Cards
                FutureBuilder<Map<String, dynamic>>(
                  future: _weatherData,
                  builder: (context, weatherSnapshot) {
                    if (weatherSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (weatherSnapshot.hasError) {
                      return Text('Error: ${weatherSnapshot.error}');
                    }
                    final data = weatherSnapshot.data!;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildHorizontalMonitoringCard(
                          icon: Icons.wb_sunny,
                          label: "Weather",
                          value: data['weather'],
                          color: Colors.orange,
                        ),
                        _buildHorizontalMonitoringCard(
                          icon: Icons.thermostat,
                          label: "Temp",
                          value: "${data['temperature']}°C",
                          color: Colors.red,
                        ),
                        _buildHorizontalMonitoringCard(
                          icon: Icons.water_drop,
                          label: "Humidity",
                          value: "${data['humidity']}%",
                          color: Colors.blue,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Bar Chart
                const Text(
                  'Plant Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                HorizontalBarChart(categoryCounts: categoryCounts),

                const SizedBox(height: 16),

                // Plant List
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Plants',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$totalPlants Plants',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: plants.length,
                    itemBuilder: (context, index) {
                      final plant = plants[index];
                      return _buildPlantCard(plant);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper function for horizontal cards
  Widget _buildHorizontalMonitoringCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12)),
                Text(value,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Function to get plant-specific icons
  IconData _getPlantIcon(String type) {
    switch (type.toLowerCase()) {
      case 'tree':
        return Icons.forest; // Tree icon
      case 'flower':
        return Icons.local_florist; // Flower icon
      case 'vegetable':
        return Icons.eco; // Vegetable icon
      case 'fruit':
        return Icons.apple; // Fruit icon
      case 'herb':
        return Icons.spa; // Herb icon
      default:
        return Icons.grass; // Default icon
    }
  }

// Function to get plant-specific colors
  Color _getPlantColor(String type) {
    switch (type.toLowerCase()) {
      case 'tree':
        return Colors.brown; // Brown for Tree
      case 'flower':
        return Colors.pink; // Pink for Flower
      case 'vegetable':
        return Colors.green; // Green for Vegetable
      case 'fruit':
        return Colors.red; // Red for Fruit
      case 'herb':
        return Colors.teal; // Teal for Herb
      default:
        return Colors.grey; // Default color
    }
  }

// Plant Card UI
  Widget _buildPlantCard(Plant plant) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0), // Adjust card spacing
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.purple[50], // Light purple background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Icon(
            _getPlantIcon(plant.type),
            color: _getPlantColor(plant.type),
            size: 32,
          ),
          const SizedBox(width: 12),

          // Plant Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${plant.type} | ${plant.status}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Count plant categories
  Map<String, int> _getCategoryCounts(List<Plant> plants) {
    final counts = <String, int>{};
    for (var plant in plants) {
      counts[plant.type] = (counts[plant.type] ?? 0) + 1;
    }
    return counts;
  }
}

class HorizontalBarChart extends StatelessWidget {
  final Map<String, int> categoryCounts;

  const HorizontalBarChart({Key? key, required this.categoryCounts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxCount = categoryCounts.values.isNotEmpty
        ? categoryCounts.values.reduce((a, b) => a > b ? a : b)
        : 1;
    final chartHeight = 10.0;
    final chartWidth = MediaQuery.of(context).size.width * 0.6;

    return Column(
      children: categoryCounts.entries.map((entry) {
        final barWidth = (entry.value / maxCount) * chartWidth;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(entry.key, style: const TextStyle(fontSize: 14)),
              ),
              Stack(
                children: [
                  Container(
                    height: chartHeight,
                    width: chartWidth,
                    color: Colors.grey[300],
                  ),
                  Container(
                    height: chartHeight,
                    width: barWidth,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Text('${entry.value}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
