import 'package:flutter/material.dart';
import 'search_widget.dart';
import 'plant_card_widget.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key}); // Add key to the constructor

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  // Sample data array
  final List<Map<String, String>> plants = const [
    {
      'name': 'Rose',
      'description':
          'Bunga mawar yang sangat indah (Deskripsi ini bakal berubah nanti)',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Tulip',
      'description':
          'Bunga tulip yang sangat indah (Deskripsi ini bakal berubah nanti)',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Cactus',
      'description':
          'Kaktus yang sangat indah (Deskripsi ini bakal berubah nanti)',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Orchid',
      'description':
          'Bunga anggrek yang sangat indah (Deskripsi ini bakal berubah nanti)',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Sunflower',
      'description':
          'Bunga matahari yang sangat indah (Deskripsi ini bakal berubah nanti)',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
  ];

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
