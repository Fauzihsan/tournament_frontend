import 'package:flutter/material.dart';
import 'package:turnamen_frontend/screens/screens.dart';
import 'package:turnamen_frontend/shared/shared.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor, canvasColor: Colors.transparent),
      routes: {
        '/': (BuildContext _) => welcomeScreen(),
        '/home': (BuildContext _) => homeScreen(),
      },
      initialRoute: '/',
    );
  }
}
