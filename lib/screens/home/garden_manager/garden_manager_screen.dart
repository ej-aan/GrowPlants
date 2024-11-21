import 'package:flutter/material.dart';

class GardenManagerScreen extends StatefulWidget {
  const GardenManagerScreen({super.key});

  @override
  _GardenManagerScreenState createState() => _GardenManagerScreenState();
}

class _GardenManagerScreenState extends State<GardenManagerScreen> {
  List<Plant> plants = []; // This would be populated from your DataService

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
            ),
          );
        },
      ),
    );
  }

  void _editPlant(Plant plant) {
    // TODO: Implement edit functionality
  }

  void _deletePlant(Plant plant) {
    // TODO: Implement delete functionality with confirmation dialog
  }
}

// lib/models/plant_model.dart
class Plant {
  final String id;
  String name;
  String type;
  String? notes;
  DateTime dateAdded;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    this.notes,
    required this.dateAdded,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'notes': notes,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      notes: json['notes'],
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }
}

// lib/services/data_service.dart
class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final List<Plant> _plants = [];

  List<Plant> get plants => List.unmodifiable(_plants);

  void addPlant(Plant plant) {
    _plants.add(plant);
    // TODO: Implement persistence
  }

  void updatePlant(Plant plant) {
    final index = _plants.indexWhere((p) => p.id == plant.id);
    if (index != -1) {
      _plants[index] = plant;
      // TODO: Implement persistence
    }
  }

  void deletePlant(String id) {
    _plants.removeWhere((plant) => plant.id == id);
    // TODO: Implement persistence
  }
}
