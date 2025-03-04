import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final Color textColor;
  final double borderRadius;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const SearchButton({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.textColor = Colors.black,
    this.borderRadius = 8.0,
    this.labelText,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: textColor),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: textColor)
              : null, // Prefix icon
          prefixIconColor: textColor,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(borderRadius), // Rounded corners
            borderSide: BorderSide(color: textColor), // Border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: textColor), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: textColor),
          ),
        ),
      ),
    );
  }
}
