import 'package:flutter/material.dart';
import 'screens/monitoring/monitoring_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/encyclopedia/encyclopedia_screen.dart';
import 'screens/home/garden_planner/garden_planner_screen.dart';
import 'screens/home/garden_manager/garden_manager_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter bindings are initialized.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Configures Firebase for the current platform.
  );
  runApp(const GrowPlantsApp()); // Launches the main app widget.
}

class GrowPlantsApp extends StatelessWidget {
  const GrowPlantsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowGuide',
      theme: ThemeData(
        primaryColor: const Color(0xFF8CB369),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF8CB369),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      // Define routes before the home property
      routes: {
        '/': (context) => const MainScreen(),
        '/gardenPlanner': (context) => GardenPlannerScreen(),
        '/gardenManager': (context) => GardenManagerScreen(),
      },
      // Set initial route instead of home
      initialRoute: '/',
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MonitoringScreen(),
    const HomeScreen(),
    EncyclopediaScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.eco),
              label: 'Monitoring',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Encyclopedia',
            ),
          ],
        ),
      ),
    );
  }
}
