import 'package:flutter/material.dart';
import 'screens/models/lesson.dart';
import 'screens/ortalamatik.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrtalaMatik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const OrtalaMatik()
    );
  }              
}