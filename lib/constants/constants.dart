import 'package:flutter/material.dart';

final cDescTextstyle = TextStyle(
  fontSize: 80,
  fontWeight: FontWeight.bold,
  color: Colors.white.withOpacity(0.9),
);

final cTempTextStyle = TextStyle(
    fontSize: 95,
    fontWeight: FontWeight.bold,
    color: Colors.white.withOpacity(0.8));

const cAPIkey = 'af2535e865107dc317d81be992dbda7a';

String calculateResult(
  double temp,
) {
  final _result = temp - 273.15;
  return _result.toStringAsFixed(1);
}
