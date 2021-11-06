import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:turnamen_frontend/screens/screens.dart';
import 'package:turnamen_frontend/shared/shared.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sp = await SharedPreferences.getInstance();
  // var email = sp.getString('email');
  // runApp(MyApp(dataEmail: jsonEncode(email)));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final String dataEmail;
  // const MyApp({Key? key, required this.dataEmail}) : super(key: key);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor, canvasColor: Colors.transparent),
      routes: {
        '/': (BuildContext _) => welcomeScreen(),
        // '/home': (BuildContext _) => splashScreenPage(email: dataEmail),
      },
      initialRoute: '/',
    );
  }
}
