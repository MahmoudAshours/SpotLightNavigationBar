import 'package:flutter/material.dart';
import 'package:spotlightnavbar/spot_lightnavbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var x = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Color(0xff3B3B3B),
        body: x == 0
            ? Center(
                child: FlutterLogo(
                  size: 600,
                ),
              )
            : Center(
                child: FlutterLogo(
                  size: 600,
                  colors: Colors.orange,
                ),
              ),
        bottomNavigationBar: SpotLightNavBar(
          onItemPressed: (i) {
            setState(() {
              x = i;
            });
          },
          icons: [
            Icon(
              Icons.disc_full,
              color: Colors.white,
            ),
            Icon(
              Icons.add_to_home_screen,
              color: Colors.white30,
            ),
          ],
        ),
      ),
    );
  }
}
