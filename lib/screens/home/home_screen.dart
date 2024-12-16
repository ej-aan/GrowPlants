import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Add key to the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hi, ready to grow today?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8CB369),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _FeatureButton(
                    label: "Garden Planner",
                    icon: Icons.add_circle_outline,
                    color: const Color(0xFFF4A259),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/gardenPlanner'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _FeatureButton(
                    label: "Garden Manager",
                    icon: Icons.edit,
                    color: const Color(0xFFF4A259),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/gardenManager'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _FeatureButton(
                    label: "Feature soon 1",
                    icon: Icons.car_rental,
                    color: const Color(0xFFF4A259),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/gardenPlanner'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _FeatureButton(
                    label: "Feature soon 2",
                    icon: Icons.access_time,
                    color: const Color(0xFFF4A259),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/gardenManager'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Expanded(
              child: Center(
                child: Text(
                  "More features coming soon!",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _FeatureButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
