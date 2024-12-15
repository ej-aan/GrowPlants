import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/plant_model.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Plant> _plants = [];
  final String _collectionKey = 'plants'; // Firestore collection name

  /// Initializes the service by loading plants from Firestore
  Future<void> initialize() async {
    await _loadPlants();
  }

  List<Plant> get plants => List.unmodifiable(_plants);

  /// Adds a new plant to Firestore
  Future<void> addPlant(Plant plant) async {
    // Add to Firestore
    final docRef =
        await _firestore.collection(_collectionKey).add(plant.toJson());

    // Update the local list with Firestore ID
    _plants.add(plant.copyWith(id: docRef.id));
  }

  /// Updates an existing plant in Firestore
  Future<void> updatePlant(Plant updatedPlant) async {
    final index = _plants.indexWhere((p) => p.id == updatedPlant.id);
    if (index != -1) {
      await _firestore
          .collection(_collectionKey)
          .doc(updatedPlant.id)
          .update(updatedPlant.toJson());
      _plants[index] = updatedPlant;
    }
  }

  /// Deletes a plant from Firestore
  Future<void> deletePlant(String id) async {
    await _firestore.collection(_collectionKey).doc(id).delete();
    _plants.removeWhere((plant) => plant.id == id);
  }

  /// Loads plants from Firestore
  Future<void> _loadPlants() async {
    final snapshot = await _firestore.collection(_collectionKey).get();

    _plants.clear();
    _plants.addAll(
      snapshot.docs.map(
        (doc) => Plant.fromJson({...doc.data(), 'id': doc.id}),
      ),
    );
  }

  Future<List<Plant>> fetchPlants() async {
    final snapshot = await _firestore.collection('plants').get();
    return snapshot.docs.map((doc) {
      return Plant.fromJson({...doc.data(), 'id': doc.id});
    }).toList();
  }
}
