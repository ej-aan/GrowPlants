import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/plant_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Plant> _plants = [];

  // Get the current user's UID
  String? get _userId => _auth.currentUser?.uid;

  Future<void> initialize() async {
    await _loadPlants();
  }

  List<Plant> get plants => List.unmodifiable(_plants);

  Future<void> addPlant(Plant plant) async {
    if (_userId == null) return; // Make sure the user is logged in

    final userPlantCollection =
        _firestore.collection('users').doc(_userId).collection('plants');
    final docRef = await userPlantCollection.add(plant.toJson());

    _plants.add(plant.copyWith(
        id: docRef.id)); // Add to the local list with Firestore ID
  }

  Future<void> updatePlant(Plant updatedPlant) async {
    if (_userId == null) return; // Pastikan user sudah login

    // Update data di Firestore
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('plants')
        .doc(updatedPlant.id)
        .update(updatedPlant.toJson());

    print("Plant updated in Firestore");
  }

  Future<void> deletePlant(String id) async {
    if (_userId == null) return; // Make sure the user is logged in

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('plants')
        .doc(id)
        .delete();
    _plants.removeWhere((plant) => plant.id == id);
  }

  /// Loads plants from Firestore for the current user
  Future<void> _loadPlants() async {
    if (_userId == null) return; // Make sure the user is logged in

    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('plants')
        .get();

    _plants.clear();
    _plants.addAll(
      snapshot.docs.map(
        (doc) => Plant.fromJson({...doc.data(), 'id': doc.id}),
      ),
    );
  }

  /// Fetches the current user's plants from Firestore
  Future<List<Plant>> fetchPlants() async {
    if (_userId == null) return []; // Make sure the user is logged in

    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('plants')
        .get();

    return snapshot.docs.map((doc) {
      return Plant.fromJson({...doc.data(), 'id': doc.id});
    }).toList();
  }
}
