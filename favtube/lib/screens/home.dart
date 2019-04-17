import 'package:favtube/delegates/data_search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("0",
                style: TextStyle(
                  color: Colors.yellow,
                )),
          ),
          IconButton(
            icon: Icon(Icons.star),
            color: Colors.yellow,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
