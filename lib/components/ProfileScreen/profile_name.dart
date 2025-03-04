import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final Color textColor;
  final double borderRadius;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const ProfileName({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.textColor = Colors.black,
    this.borderRadius = 8.0,
    this.onChanged,
    this.errorText,
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
        onChanged: onChanged,
        style: TextStyle(color: textColor), // Set text color
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: textColor,
          ), // Hint text color
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
            borderSide: BorderSide(color: textColor), // Enabled border color
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                const BorderSide(color: Colors.red), // Error border color
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
                color: Colors.red), // Focused error border color
          ),
        ),
      ),
    );
  }
}
