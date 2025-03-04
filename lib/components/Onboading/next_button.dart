import 'package:ug/screens/Login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Custom Next Button
    return CircleAvatar(
      foregroundColor: Colors.white70,
      radius: screenWidth * 0.07,
      backgroundColor: CupertinoColors.black,
      child: IconButton.filled(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        icon: Center(
          child: Icon(
            CupertinoIcons.arrow_right,
            size: screenWidth * 0.07,
          ),
        ),
      ),
    );
  }
}
