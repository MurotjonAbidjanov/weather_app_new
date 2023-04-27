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

const cAPIkey = 'ec97226a0b8acfa6c3feb070a89126ef';

const cHttpCityName =
    'https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}';


const cHttpLatLong =
    'https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}';
