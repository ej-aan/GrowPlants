import 'package:flutter/material.dart';
import 'package:growplants/models/plant_model.dart'; // Import model Plant
import 'package:growplants/services/data_service.dart'; // Import DataService
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonitoringScreen extends StatefulWidget {
  @override
  _MonitoringScreenState createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  List<Plant> _plants = [];
  late Future<Map<String, dynamic>> _weatherData;

  @override
  void initState() {
    super.initState();
    _loadPlants();  // Memuat data tanaman pada awalnya
    _weatherData = getWeatherData(); // Memanggil API untuk data cuaca
  }

  // Fungsi untuk mengambil data tanaman dari DataService
  Future<void> _loadPlants() async {
    await DataService().initialize(); // Memastikan data tanaman sudah dimuat
    setState(() {
      _plants = DataService().plants; // Mengambil data tanaman dari DataService
    });
  }

  // Fungsi untuk mengambil data cuaca
  Future<Map<String, dynamic>> getWeatherData() async {
    final apiKey = '8332a45935231c915e766a727c9a46d7'; // Ganti dengan API key yang valid
    final city = 'Surabaya'; // Ganti dengan kota yang sesuai
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

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
    final categoryCounts = _getCategoryCounts(_plants); // Menghitung jumlah tanaman per kategori
    final totalPlants = _plants.length; // Menghitung total jumlah tanaman

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CB369),
        title: const Text(
          "Monitoring",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather, Temperature, and Humidity Monitoring
            FutureBuilder<Map<String, dynamic>>(
              future: _weatherData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
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
                } else {
                  return const Text('No data available');
                }
              },
            ),
            const SizedBox(height: 16),

            // Grafik Batang Horizontal
            const Text(
              'Plant Categories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 170,
              child: HorizontalBarChart(categoryCounts: categoryCounts),
            ),

            const SizedBox(height: 16),

            // "Your Plants" + Total Tanaman
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Plants',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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

            // Menampilkan Daftar Tanaman dengan Tampilan ListView Vertikal
            _plants.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _plants.length,
                      itemBuilder: (context, index) {
                        final plant = _plants[index];
                        return _buildPlantCard(plant);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Horizontal Monitoring Cards
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
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun kartu tanaman
  Widget _buildPlantCard(Plant plant) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            // child: Image.network(
            //   plant.imageUrl, // Asumsi ada field imageUrl di model Plant
            //   height: 120,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
          ),
           Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row untuk nama tanaman dan kategori tanaman di kanan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    plant.name, // Nama tanaman
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Kategori tanaman di sebelah kanan
                  Row(
                    children: [
                      _getCategoryIcon(plant.type), // Ikon kategori tanaman
                      const SizedBox(width: 8),
                      Text(plant.type, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _getCategoryIcon(plant.type), // Ikon kategori tanaman
                  const SizedBox(width: 8),
                  Text(plant.status), // Status tanaman (misalnya: "Healthy")
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // Helper function to get category icon
  Widget _getCategoryIcon(String category) {
    switch (category) {
      case "Vegetable":
        return const Icon(Icons.eco, color: Colors.green, size: 20);
      case "Herb":
        return const Icon(Icons.grass, color: Colors.green, size: 20);
      case "Fruit":
        return const Icon(Icons.apple, color: Colors.red, size: 20);
        case "Tree":
        return const Icon(Icons.nature_people, color: Colors.brown, size: 20);
      case "Flower":
      default:
        return const Icon(Icons.local_florist, color: Colors.pink, size: 20);
    }
  }

  // Fungsi untuk menghitung jumlah tanaman per kategori
  Map<String, int> _getCategoryCounts(List<Plant> plants) {
    final counts = <String, int>{};
    for (var plant in plants) {
      final category = plant.type; // Gunakan properti 'type' dari model Plant
      counts[category] = (counts[category] ?? 0) + 1;
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
    final maxCount = categoryCounts.values.isEmpty
        ? 1
        : categoryCounts.values.reduce((a, b) => a > b ? a : b);
    final chartHeight = 10.0; // Height of each bar
    final chartWidth = MediaQuery.of(context).size.width * 0.6; // Max bar width

    return Column(
      children: categoryCounts.entries.map((entry) {
        final category = entry.key;
        final count = entry.value;
        final barWidth = (count / maxCount) * chartWidth;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  category,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: chartHeight,
                    width: chartWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    height: chartHeight,
                    width: barWidth,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Text('$count', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
