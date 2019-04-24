import 'package:favtube/blocs/videos_bloc.dart';
import 'package:favtube/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: MaterialApp(
        title: 'FavTube',
        theme: ThemeData(
          primaryColor: Colors.grey,
        ),
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
