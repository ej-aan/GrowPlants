import 'package:flutter/material.dart';
import 'models/plant_model.dart';
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
                backgroundColor:  Color(0xFF5B8E7D),
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
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8CB369),
        child: const Icon(Icons.add),
        onPressed: _addPlant,
      ),
    );
  }

  void _addPlant() async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PlantForm(),
    ),
  );
  setState(() {}); // Refresh list
}


  void _editPlant(Plant plant) async {
    await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlantForm(plant: plant),
    ),
  );
  setState(() {}); // Refresh list
  }

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
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}