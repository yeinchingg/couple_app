import 'package:couple_app/screens/photo.dart';
import 'package:couple_app/screens/profile.dart';
import 'package:flutter/material.dart';
import 'screens/calender.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Couple App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}