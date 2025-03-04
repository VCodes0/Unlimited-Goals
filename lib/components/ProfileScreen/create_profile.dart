import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final IconData? icon;

  const CreateProfile({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.icon, // Icon is now optional
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 55,
      width: screenWidth * (250 / 275),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CupertinoColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        label: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
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
