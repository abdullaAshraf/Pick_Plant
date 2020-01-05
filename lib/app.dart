import 'package:flutter/material.dart';
import 'screens/home_material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pick Plant',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF34A163),
        primaryColorDark: Color(0xFF39975F),
        canvasColor: Colors.transparent,

      ),
      home: HomeMaterial(),
    );
  }
}

//  #39975F
// #34A163