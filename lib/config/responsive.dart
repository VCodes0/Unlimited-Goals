import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;
  
  static bool isMobile(BuildContext context) => width(context) < mobileBreakpoint;
  static bool isTablet(BuildContext context) => 
      width(context) >= mobileBreakpoint && width(context) < tabletBreakpoint;
  static bool isDesktop(BuildContext context) => width(context) >= tabletBreakpoint;
  
  // Dynamic spacing
  static double sp(BuildContext context, double value) => 
      width(context) * (value / 1000); // Scale factor of 1000
} 