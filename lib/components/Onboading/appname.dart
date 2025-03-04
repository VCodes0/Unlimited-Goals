import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // App Name
    return Text(
      "GOALS UNLIMITED",
      style: TextStyle(
        // Adjust the multiplier as needed
        fontSize: screenWidth * 0.08,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
