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

  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final sp = await _prefs;
  String email = "";
  try {
    email = sp.getString('email') ?? "";
    print("sp ada");
  } catch (e) {
    print(e);
  }

  runApp(MyApp(dataEmail: email));
}

class MyApp extends StatelessWidget {
  final String dataEmail;
  // const MyApp({Key? key, required this.dataEmail}) : super(key: key);

  const MyApp({Key? key, required this.dataEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor, canvasColor: Colors.transparent),
      routes: {
        '/': (BuildContext _) => splashScreenPage(email: dataEmail),
        // '/home': (BuildContext _) => splashScreenPage(email: dataEmail),
      },
      initialRoute: '/',
    );
  }
}
