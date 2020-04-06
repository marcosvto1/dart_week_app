
import 'package:flutter/material.dart';

class ThemeUtils {
  static Color primmaryColor;

  static init(BuildContext context) {
    primmaryColor = Theme.of(context).primaryColor;
  }
}