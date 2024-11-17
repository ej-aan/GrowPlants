import 'package:flutter/material.dart';

class EncyclopediaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CB369),
        title: const Text(
          "Plant Encyclopedia",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text('Explore plants in the encyclopedia.'),
      ),
    );
  }
}
