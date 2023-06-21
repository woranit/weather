import 'package:flutter/material.dart';
import 'package:weather/styles/color.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: const Size(220, 50),
  disabledBackgroundColor: lightblue,
  backgroundColor: blue,
  elevation: 0,
  //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50),
  ),
);
