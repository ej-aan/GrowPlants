import 'package:flutter/material.dart';
import 'search_widget.dart';
import 'plant_card_widget.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  // Sample data array
  final List<Map<String, String>> plants = const [
    {
      'name': 'Rose',
      'description': 'A symbol of love and passion.',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Tulip',
      'description': 'Known for its beautiful blossoms.',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Cactus',
      'description': 'A resilient desert plant.',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Orchid',
      'description': 'Elegant and exotic flowers.',
      'imageUrl':
          'https://asset.kompas.com/crops/lwBZvBbN1kkeOhogiKLZusjzGCI=/83x64:1908x1280/750x500/data/photo/2021/01/31/6016a4e1c4716.jpg'
    },
    {
      'name': 'Sunflower',
      'description': 'Bright and cheerful blooms.',
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF8CB369),
        title: const Text(
          "Plant Encyclopedia",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
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
