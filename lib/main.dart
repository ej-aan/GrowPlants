import 'package:flutter/material.dart';
import 'screens/auth/auth_wrapper.dart'; // Import the AuthWrapper
import 'screens/home/garden_manager/garden_manager_screen.dart';
import 'screens/home/garden_planner/garden_planner_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/main_screen.dart'; // Import MainScreen
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

  runApp(const GrowPlantsApp());
}

class GrowPlantsApp extends StatelessWidget {
  const GrowPlantsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowPlants',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const AuthWrapper(), // Set AuthWrapper as the entry point
      routes: {
        '/mainScreen': (context) => const MainScreen(), // Route for MainScreen
        '/gardenManager': (context) =>
            GardenManagerScreen(), // Route for Garden Manager
        '/gardenPlanner': (context) =>
            GardenPlannerScreen(), // Route for Garden Planner
        '/signIn': (context) => const SignInScreen(), // Route for Sign In
        '/signUp': (context) => const SignUpScreen(), // Route for Sign Up
      },
    );
  }
}
