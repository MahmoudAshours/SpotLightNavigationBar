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
  PageController _controller;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  var x = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: PageView(
          controller: _controller,
          children: <Widget>[
            Center(
              child: FlutterLogo(),
            ),
            Center(
              child: FlutterLogo(
                colors: Colors.orange,
              ),
            )
          ],
        ),
        bottomNavigationBar: SpotLightNavBar(
          animationDuration: Duration(seconds: 1),
          onItemPressed: (i) {
            setState(() => x = i);
          },
          selectedItemColor: Colors.red,
          nonSelectedItemColor: Colors.blue,
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
            Row(
              children: [Text('hihi'), Icon(Icons.add_to_home_screen)],
            ),
            Row(
              children: [Text('hihi'), Icon(Icons.add_to_home_screen)],
            ),
          ],
        ),
      ),
    );
  }
}
