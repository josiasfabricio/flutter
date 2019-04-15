import 'package:flutter/material.dart';
import 'package:virtual_store_manager/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: Theme.of(context).primaryColor,
                    size: 160,
                  ),
                  InputField(
                    icon: Icons.person_outline,
                    hint: "User",
                    obscure: false,
                  ),
                  InputField(
                    icon: Icons.lock_outline,
                    hint: "Password",
                    obscure: true,
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Enter"),
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
