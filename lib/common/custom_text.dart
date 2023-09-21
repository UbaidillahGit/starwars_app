import 'package:flutter/material.dart';

class CustomText {
  Text starjediWhite({required String txt, double size = 13, TextAlign textAlign = TextAlign.start}) {
    return Text(
      txt, 
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Starjedi', 
        color: Colors.white,
        fontSize: size,
      )
    );
  }
}