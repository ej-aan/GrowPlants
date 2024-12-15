import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/plant_model.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final List<Plant> _plants = [];
  final String _storageKey = 'plants_data';

  Future<void> initialize() async {
    await _loadPlants();
  }

  List<Plant> get plants => List.unmodifiable(_plants);

  Future<void> addPlant(Plant plant) async {
    _plants.add(plant);
    await _savePlants();
  }

  Future<void> updatePlant(Plant updatedPlant) async {
    final index = _plants.indexWhere((p) => p.id == updatedPlant.id);
    if (index != -1) {
      _plants[index] = updatedPlant;
      await _savePlants();
    }
  }

  Future<void> deletePlant(String id) async {
    _plants.removeWhere((plant) => plant.id == id);
    await _savePlants();
  }

  Future<void> _loadPlants() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedData = prefs.getString(_storageKey);

    if (storedData != null) {
      final List<dynamic> jsonData = jsonDecode(storedData);
      _plants.clear();
      _plants.addAll(jsonData.map((data) => Plant.fromJson(data)));
    }
  }

  Future<void> _savePlants() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString =
        jsonEncode(_plants.map((plant) => plant.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }
}
