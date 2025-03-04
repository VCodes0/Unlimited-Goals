import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const OnboardingButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(buttonText),
      ),
    );
  }
}
