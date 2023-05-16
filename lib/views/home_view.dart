import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_new/views/search_view.dart';
import '../constants/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String city = '';
  double temp = 0;
  String country = '';

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

  showCurentData(Position position) async {
    var client = http.Client();
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$cAPIkey');
    try {
      final data = await client.get(uri);
      final jsonAnswer = jsonDecode(data.body);
      city = jsonAnswer['name'];
      final kelvin = jsonAnswer['main']['temp'];
      temp = kelvin - 273.15;
      setState(() {});
      country = jsonAnswer['sys']['country'];
      log('country =====> $country');
      log('city =====> $city');
      log('temp =====> ${temp.toStringAsFixed(0)}');
    } catch (e) {
      print('$e');
    }
  }

  showWeatherLocation() async {
    final position = await getPosition();
    await showCurentData(position);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            city,
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
                child: Text('${temp.toStringAsFixed(0)}°C'.toUpperCase(),
                    style: cTempTextStyle),
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
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 15,
                bottom: 5,
                child: Text(
                  country,
                  style: TextStyle(fontSize: 60, color: Colors.grey[500], fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
