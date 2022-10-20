import 'package:flutter/material.dart';
import 'package:parcial3/vistas/inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Api freetogame',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      //theme: ThemeData.light(),
      home: inicio(),
    );
  }
}
     