import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final IconData? icon;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.icon, // Icon is now optional
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 50,
      width: screenWidth * (250 / 375),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CupertinoColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        label: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        icon: icon != null // Conditionally render the icon
            ? Icon(
                icon,
                color: Colors.white,
              )
            : const SizedBox.shrink(), // Or another placeholder if needed
      ),
    );
  }
}
