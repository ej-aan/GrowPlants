import 'package:flutter/material.dart';
import '../../../models/plant_model.dart';
import 'plant_form.dart';
import '../../../services/data_service.dart';

class GardenManagerScreen extends StatefulWidget {
  const GardenManagerScreen({super.key});

  @override
  _GardenManagerScreenState createState() => _GardenManagerScreenState();
}

class _GardenManagerScreenState extends State<GardenManagerScreen> {
  late List<Plant> plants;

  @override
  void initState() {
    super.initState();
    // Load plants from DataService
    plants = DataService().plants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CB369),
        title: const Text('Garden Manager'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF5B8E7D),
                child: Icon(
                  Icons.eco,
                  color: Colors.white,
                ),
              ),
              title: Text(
                plant.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(plant.type),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFFF4A259)),
                    onPressed: () => _editPlant(plant),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFBC4B51)),
                    onPressed: () => _deletePlant(plant),
                  ),
                ],
              ),
              onTap: () => _showPlantDetails(plant), // Show details popup
            ),
          );
        },
      ),
    );
  }

  // Method untuk edit tanaman
  void _editPlant(Plant plant) async {
    // Arahkan ke PlantForm dan tunggu hasilnya
    final updatedPlant = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantForm(plant: plant),
      ),
    );

    // Jika tanaman diperbarui, update list tanaman
    if (updatedPlant != null) {
      setState(() {
        int index = plants.indexWhere((p) => p.id == plant.id);
        if (index != -1) {
          plants[index] = updatedPlant; // Update plant
        }
      });
    }
  }

  // Method untuk delete tanaman
  void _deletePlant(Plant plant) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Plant'),
        content: Text('Are you sure you want to delete ${plant.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                DataService().deletePlant(plant.id);
                plants.removeWhere(
                    (p) => p.id == plant.id); // Remove plant from list
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Method untuk menampilkan detail tanaman
  void _showPlantDetails(Plant plant) {
    showDialog(
      context: context,
      builder: (context) => PlantDetailPopup(plant: plant),
    );
  }
}

class PlantDetailPopup extends StatelessWidget {
  final Plant plant;

  const PlantDetailPopup({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(plant.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Type', plant.type),
            _buildDetailRow('Size', plant.size),
            _buildDetailRow('Light Requirement', plant.lightRequirement),
            _buildDetailRow('Water Requirement', plant.waterRequirement),
            _buildDetailRow('Soil Requirement', plant.soilRequirement),
            _buildDetailRow('Growth Status', plant.status),
            if (plant.notes != null && plant.notes!.isNotEmpty)
              _buildDetailRow('Notes', plant.notes!),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
