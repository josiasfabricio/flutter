import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=52a3caba";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();
  final poundController = TextEditingController();
  final bitcoinController = TextEditingController();

  double _dollar;
  double _euro;
  double _pound;
  double _bitcoin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Convertor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:

              _dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
              _euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
              _pound = snapshot.data["results"]["currencies"]["GBP"]["buy"];
              _bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"];

              return SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on,
                      size: 150.0,
                      color: Colors.amber,
                    ),
                    buildTextField(
                        "Real", "R\$ ", realController, _realChanged),
                    Divider(),
                    buildTextField(
                        "Dollar", "US\$ ", dollarController, _dollarChanged),
                    Divider(),
                    buildTextField("Euro", "€ ", euroController, _euroChanged),
                    Divider(),
                    buildTextField("Pound Sterling", "£ ", poundController, _poundChanged),
                    Divider(),
                    buildTextField("Bitcoin", "฿ ", bitcoinController, _bitcoinChanged)
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: buildText("Loading Data..."),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: buildText("Error at Load Data"),
                );
              }
          }
        },
      ),
    );
  }

  void _realChanged(String text) {
    double real = double.parse(text);
    dollarController.text = (real / _dollar).toStringAsFixed(2);
    euroController.text = (real / _euro).toStringAsFixed(2);
    poundController.text = (real / _pound).toStringAsFixed(2);
    bitcoinController.text = (real / _bitcoin).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    double dollar = double.parse(text);
    realController.text = (dollar * _dollar).toStringAsFixed(2);
    euroController.text = (dollar * _dollar / _euro).toStringAsFixed(2);
    poundController.text = (dollar * _dollar / _pound).toStringAsFixed(2);
    bitcoinController.text = (dollar * _dollar / _bitcoin).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * _euro).toStringAsFixed(2);
    dollarController.text = (euro * _euro / _dollar).toStringAsFixed(2);
    bitcoinController.text = (euro * _euro / _bitcoin).toStringAsFixed(2);
    poundController.text = (euro * _euro / _pound).toStringAsFixed(2);
  }

  void _poundChanged(String text) {
    double pound = double.parse(text);
    //realController.text = (pound * _euro).toStringAsFixed(2);
    //dollarController.text = (euro * _euro / _dollar).toStringAsFixed(2);
  }

  void _bitcoinChanged(String text) {
    double bitcoin = double.parse(text);
    //realController.text = (euro * _euro).toStringAsFixed(2);
    //dollarController.text = (euro * _euro / _dollar).toStringAsFixed(2);
  }
}

Widget buildTextField(
    String label, String symbol, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: symbol),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}

Widget buildText(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    textAlign: TextAlign.center,
  );
}
