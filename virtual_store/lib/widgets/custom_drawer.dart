import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 130.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Virtual Store",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              (model.userData != null && model.isLoggedIn())
                                  ? Text("Hi, ${model.userData["name"]}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ))
                                  : SizedBox(
                                      height: 0.0,
                                    ),
                              GestureDetector(
                                child: Text(
                                  model.isLoggedIn()
                                      ? "Logout >"
                                      : "Login or Sign Up >",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                onTap: () {
                                  if (model.isLoggedIn())
                                    model.signOut();
                                  else
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    }));
                                },
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Home", pageController, 0),
              DrawerTile(Icons.list, "Produtcs", pageController, 1),
              DrawerTile(Icons.location_on, "Stores", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "My Orders", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
