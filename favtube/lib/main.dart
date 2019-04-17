import 'package:favtube/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FavTube',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
