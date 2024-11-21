import 'package:flutter/material.dart';

class MonitoringScreen extends StatelessWidget {
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
            // Section Title
            const Text(
              'Garden Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 24),

            // Total Plants Information
            _buildTotalPlantsInfo(plants.length),
            const SizedBox(height: 24),

            // Plant List Section
            const Text(
              'Your Plants',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Plant List
            Expanded(
              child: ListView.builder(
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  final plant = plants[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
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
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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

  // Widget for Total Plants Info
  Widget _buildTotalPlantsInfo(int totalPlants) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total Plants",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            "$totalPlants",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
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
        return const Icon(Icons.local_florist, color: Colors.white);
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
}
