import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "SIGN UP",
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "Invalid e-mail!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                        decoration: InputDecoration(hintText: "Password"),
                        obscureText: true,
                        validator: (text) {
                          if (text.isEmpty || text.length < 6)
                            return "Invalid password!";
                        }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot your login?",
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                        child: Text(
                          "Enter",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                          }
                          model.signIn();
                        },
                      ),
                    )
                  ],
                ));
        },
      ),
    );
  }
}
