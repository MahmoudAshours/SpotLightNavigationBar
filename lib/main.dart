import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spotlightnavbar/spot_lightnavbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _controller;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  var index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Color(0xff3B3B3B),
        body: index == 0
            ? Center(
                child: FlutterLogo(
                  colors: Colors.orange,
                  size: 300,
                ),
              )
            : index == 1
                ? Center(child: FlutterLogo(size: 250))
                : Center(
                    child: FlutterLogo(
                      size: 200,
                      colors: Colors.red,
                    ),
                  ),
        bottomNavigationBar: SpotLightNavBar(
          animationDuration: Duration(seconds: 1),
          onItemPressed: (i) {
            setState(() => index = i);
          },
          selectedItemColor: Colors.white,
          bottomNavBarColor: Color(0xff3B3B3B),
          nonSelectedItemColor: Colors.white30,
          items: [
            Icon(
              Icons.grain,
            ),
            Icon(
              Icons.search,
            ),
            Icon(
              Icons.flag,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
