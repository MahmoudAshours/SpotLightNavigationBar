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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Color(0xff3B3B3B),
        bottomNavigationBar: SpotLightNavBar(
          icons: [
            Icon(Icons.disc_full , color: Colors.white,),
            Icon(Icons.add_to_home_screen , color: Colors.white30,),
          ],
        ),
      ),
    );
  }
}
