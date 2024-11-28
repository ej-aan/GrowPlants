import 'package:flutter/material.dart';

class MonitoringScreen extends StatefulWidget {
  @override
  _MonitoringScreenState createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  final List<Map<String, String>> plants = [
    {"name": "Aloe Vera", "notes": "Water every 2 days", "category": "Herb"},
    {"name": "Basil", "notes": "Requires sunlight", "category": "Herb"},
    {"name": "Cactus", "notes": "Water once a week", "category": "Flower"},
    {"name": "Carrot", "notes": "Keep in humid areas", "category": "Vegetable"},
    {"name": "Mint", "notes": "Trim regularly", "category": "Herb"},
    {"name": "Violet", "notes": "Water everyday", "category": "Flower"},
    {"name": "Hydrangea", "notes": "Water every 18 hours", "category": "Flower"},
    {"name": "Hibiscus", "notes": "Trim regularly", "category": "Flower"},
    {"name": "Lily", "notes": "Water everyday", "category": "Flower"},
    {"name": "Grape", "notes": "Trim regularly", "category": "Fruit"},
  ];

  @override
  Widget build(BuildContext context) {
    final categoryCounts = _getCategoryCounts(plants);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHorizontalMonitoringCard(
                  icon: Icons.wb_sunny,
                  label: "Weather",
                  value: "Sunny",
                  color: Colors.orange,
                ),
                _buildHorizontalMonitoringCard(
                  icon: Icons.thermostat,
                  label: "Temp",
                  value: "25°C",
                  color: Colors.red,
                ),
                _buildHorizontalMonitoringCard(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  value: "60%",
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Grafik Batang Horizontal
            const Text(
              'Plant Categories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: HorizontalBarChart(categoryCounts: categoryCounts),
            ),

            const SizedBox(height: 0.1),

            // Plant List Section with Total Plants
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Plants',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Total: ${plants.length}', // Tambahkan total jumlah tanaman di sini
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),

            // Plant List
            Expanded(
              child: ListView.builder(
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  final plant = plants[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 3.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getCategoryColor(plant["category"]!),
                        child: _getCategoryIcon(plant["category"]!),
                      ),
                      title: Text(plant["name"]!), // Plant name
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plant["notes"]!), // Plant notes
                          Text(
                            "Category: ${plant["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  );
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

  // Helper function to get category icon
  Widget _getCategoryIcon(String category) {
    switch (category) {
      case "Vegetable":
        return const Icon(Icons.eco, color: Colors.white);
      case "Herb":
        return const Icon(Icons.grass, color: Colors.white);
      case "Fruit":
        return const Icon(Icons.apple, color: Colors.white);
      case "Flower":
      default:
        return const Icon(Icons.local_florist, color: Colors.white);
    }
  }

  // Helper function to get category color
  Color _getCategoryColor(String category) {
    switch (category) {
      case "Vegetable":
        return Colors.orange;
      case "Herb":
        return Colors.green;
      case "Fruit":
        return Colors.purple;
      case "Flower":
      default:
        return Colors.pink;
    }
  }

  // Function to count plants by category
  Map<String, int> _getCategoryCounts(List<Map<String, String>> plants) {
    final counts = <String, int>{};
    for (var plant in plants) {
      final category = plant["category"]!;
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
    final maxCount = categoryCounts.values.reduce((a, b) => a > b ? a : b);
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
