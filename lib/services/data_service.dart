import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home/garden_manager/models/plant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Plant>> fetchPlants() async {
    final snapshot = await _firestore.collection('plants').get();
    return snapshot.docs.map((doc) => Plant.fromJson(doc.data())).toList();
  }

  Future<void> addPlant(Plant plant) async {
    await _firestore.collection('plants').add(plant.toJson());
  }

  Future<void> updatePlant(Plant plant) async {
    final snapshot = await _firestore
        .collection('plants')
        .where('id', isEqualTo: plant.id)
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update(plant.toJson());
    }
  }

  Future<void> deletePlant(String id) async {
    final snapshot =
        await _firestore.collection('plants').where('id', isEqualTo: id).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
