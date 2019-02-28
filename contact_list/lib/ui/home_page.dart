import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:contact_list/ui/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper _helper = ContactHelper();
  List<Contact> _contacts = List();

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            return _contatcCard(context, index);
          }),
    );
  }

  Widget _contatcCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _contacts[index].img != null
                            ? FileImage(File(_contacts[index].img))
                            : AssetImage("images/profile_default.png")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _contacts[index].name ?? "",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _contacts[index].email ?? "",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Text(
                        _contacts[index].phone ?? "",
                        style: TextStyle(fontSize: 14.0),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _getAllContacts() {
    _helper.getAllContacts().then((list) {
      setState(() {
        _contacts = list;
      });
    });
  }

  void _showContactPage({Contact c}) async {
    final savedContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: c,
                )));
    if (savedContact != null) {
      if (c != null)
        await _helper.updateContact(savedContact);
      else
        await _helper.saveContact(savedContact);

      _getAllContacts();
    }
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Call",
                          style: TextStyle(color: Colors.red, fontSize: 20.0
                          ),
                        ),
                        onPressed: (){},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.red, fontSize: 20.0
                          ),
                        ),
                        onPressed: (){
                          _showContactPage(c: _contacts[index]);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red, fontSize: 20.0
                          ),
                        ),
                        onPressed: (){
                          _helper.deleteContact(_contacts[index].id);
                            _contacts.removeAt(index);
                            Navigator.pop(context);
                            _getAllContacts();
                        },
                      ),
                    )
                  ],
                ),
              );
            }, onClosing: () {},
          );
        });
  }
}
