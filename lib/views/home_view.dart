import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_new/views/search_view.dart';
import '../constants/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    showWeatherLocation();
    super.initState();
  }

  showWeatherLocation() async {
    final position = await getPosition();
    log('current LATITUDE ${position.latitude}');
    log('current LONGITUDE ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Osh',
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9)),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {},
            child: Icon(
              Icons.near_me,
              size: 35,
            ),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchView()),
                  );
                },
                child: Icon(
                  Icons.location_city,
                  size: 35,
                ))
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sunrise.jpg'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 120,
                left: 20,
                child: Text('19°C'.toUpperCase(), style: cTempTextStyle),
              ),
              Positioned(
                top: 110,
                right: 110,
                child: Text(
                  '☀',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              ),
              Positioned(
                right: 30,
                top: 350,
                child: Text(
                  'You\'ll',
                  style: cDescTextstyle,
                ),
              ),
              Positioned(
                top: 440,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      'need',
                      style: cDescTextstyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '🍨',
                      style: cDescTextstyle,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 530,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      'and',
                      style: cDescTextstyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '🧃',
                      style: cDescTextstyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
