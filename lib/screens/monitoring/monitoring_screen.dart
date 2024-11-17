import 'package:flutter/material.dart';

class MonitoringScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CB369),
        title: const Text(
          "Monitoring",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Garden Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    title: Text('Water Carrots Today'),
                    leading: Icon(Icons.opacity, color: Colors.blue),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Fertilize Tomatoes'),
                    leading: Icon(Icons.local_florist, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
