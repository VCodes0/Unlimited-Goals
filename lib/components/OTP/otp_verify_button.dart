import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 50,
      width: screenWidth * (250 / 375),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CupertinoColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
