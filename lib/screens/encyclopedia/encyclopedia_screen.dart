import 'package:flutter/material.dart';
import 'search_widget.dart';
import 'plant_card_widget.dart';
import 'encyclopedia_data.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key}); // Add key to the constructor

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  String searchQuery = "";

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchWidget(onSearch: updateSearchQuery),
          Expanded(
            child: PlantGrid(
              plants: plants,
              searchQuery: searchQuery,
            ),
          ),
        ],
      ),
    );
  }
}
