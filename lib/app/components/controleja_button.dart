import 'package:dart_week_app/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class ControleJaButton extends RawMaterialButton {
  ControleJaButton({
   @required VoidCallback onPressed,
   @required String label,
   Color primaryColor,
   Color higthlightColor
  }): super(onPressed: onPressed,
  child: Container(    
    padding: EdgeInsets.all(10),
    height: 60,
    alignment: Alignment.center,
    child: Text(
      label, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
  ), 
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  fillColor: primaryColor ?? ThemeUtils.primmaryColor,
  //highlightColor: highlightColor ?? primaryColor
  );
}