import 'dart:ui';

import 'package:flutter/material.dart';

class CO2ColorCalculator {
  static Color getColorForCO2(int co2) {
    // Define the CO2 value range
    double minCO2 = 0.0;
    double maxCO2 = 50.0;

    // Define the colors for the gradient
    Color lowCO2Color = Colors.green;
    Color highCO2Color = Colors.red;

    // Ensure the CO2 value is within the expected range
    num clampedCO2 = co2.clamp(minCO2, maxCO2);

    // Calculate the position of the CO2 value within the range
    double position = (clampedCO2 - minCO2) / (maxCO2 - minCO2);

    // Interpolate the color based on the position
    return Color.lerp(lowCO2Color, highCO2Color, position)!;
  }
}
