import 'package:flutter/material.dart';
import 'package:weather_app_new/views/home_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sunrise.jpg'),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.values.elementAt(0),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 3, color: Colors.white.withOpacity(0.5))),
                      suffixIcon: IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView(_controller.text)));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white.withOpacity(0.7),
                          )),
                      hintText: 'search region',
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 3),
                      ),
                      focusColor: Colors.black87,
                      labelText: 'Region',
                      labelStyle: TextStyle(color: Colors.black87),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.black45,
                            width: 3,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
