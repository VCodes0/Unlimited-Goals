import 'package:flutter/material.dart';
import 'package:ug/config/responsive.dart';

class OTPVerifyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const OTPVerifyButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFECD01),
        padding: EdgeInsets.symmetric(
          vertical: Responsive.sp(context, 15),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.black,
          fontSize: Responsive.sp(context, 35),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
