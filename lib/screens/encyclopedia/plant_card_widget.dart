import 'package:flutter/material.dart';
import 'plant_detail.dart';

class PlantGrid extends StatelessWidget {
  final List<Map<String, String>> plants;
  final String searchQuery;

  const PlantGrid({super.key, required this.plants, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final filteredPlants = plants.where((plant) {
      final name = plant['name']!.toLowerCase();
      final description = plant['description']!.toLowerCase();
      return name.contains(searchQuery) || description.contains(searchQuery);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah Kolom
          crossAxisSpacing: 8, // Gap antara kolom
          mainAxisSpacing: 8, // Gap antara baris
          childAspectRatio: 3 / 4, // Rasio panjang/lebar
        ),
        itemCount: filteredPlants.length,
        itemBuilder: (context, index) {
          final plant = filteredPlants[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: AssetImage(plant['imageAsset']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    plant['name']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8CB369),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantDetailScreen(plant: plant),
                        ),
                      );
                    },
                    child: const Text(
                      'Learn More',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
