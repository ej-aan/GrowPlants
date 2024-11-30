import 'package:flutter/material.dart';
import 'package:growplants/models/plant_model.dart'; // Pastikan import model Plant
import 'package:growplants/screens/home/garden_manager/garden_manager_screen.dart';

class MonitoringScreen extends StatefulWidget {
  @override
  _MonitoringScreenState createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  // List tanaman yang akan ditampilkan
  List<Plant> plants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CB369),
        title: const Text("Monitoring"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daftar Tanaman
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Plants',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Total: ${plants.length}', // Tampilkan jumlah tanaman
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Daftar Tanaman
            Expanded(
              child: ListView.builder(
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  final plant = plants[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 3.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getCategoryColor(plant.type),
                        child: _getCategoryIcon(plant.type),
                      ),
                      title: Text(plant.name),
                      subtitle: Text(plant.type),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8CB369),
        onPressed: () async {
          final updatedPlants = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GardenManagerScreen(), // Menampilkan halaman GardenManager
            ),
          );
          // Jika ada perubahan pada list tanaman, kita update state
          if (updatedPlants != null) {
            setState(() {
              plants = List<Plant>.from(updatedPlants);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Helper function untuk icon kategori
  Icon _getCategoryIcon(String category) {
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

  // Helper function untuk warna kategori
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
