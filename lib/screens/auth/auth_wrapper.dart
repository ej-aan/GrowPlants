import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main_screen.dart'; // Import MainScreen
import 'sign_in_screen.dart'; // Import SignInScreen

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Stream real-time auth state
      builder: (context, snapshot) {
        // Debugging log
        print('Auth State: ${snapshot.hasData ? "Logged In" : "Logged Out"}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Jika user sudah login, tampilkan MainScreen, jika tidak, ke SignInScreen
        if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
