import "package:flutter/material.dart";

void main(){
  runApp(MaterialApp(
    title: "People Counter",
    home: Column(
      children: <Widget>[
        Text("People: 0", style: TextStyle(color: Colors.white),)
      ],
    )
  ));
}