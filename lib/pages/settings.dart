// ignore_for_file: use_key_in_widget_constructors, annotate_overrides, avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planture_app/constants/constants.dart';
import 'package:planture_app/pages/app_info.dart';
import 'package:planture_app/pages/auth/login.dart';
import 'package:planture_app/pages/contact_us.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void initState() {
    super.initState();
    //Provider.of<loggedUser>(context).getCurrentUser();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
          print(loggedInUser.email);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  ListTile listBuilder({Icon ico, Text txt}) {
    return ListTile(
      leading: ico,
      title: txt,
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //FirebaseUser loggedInUser =  Provider.of<loggedUser>(context) as FirebaseUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.settings,
          color: Colors.greenAccent,
          size: 28.0,
        ),
        title: Text(
          'Settings',
          style: kPagetitle,
        ),
      ),
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8.0),
                child: Text('Account', style: kPagetitle),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 22,
                    color: Colors.greenAccent,
                  ),
                  title: Text(
                    loggedInUser != null ? loggedInUser.email : '',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8.0),
                child: Text('About', style: kPagetitle),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AppInfo())),
                      child: listBuilder(
                          ico: Icon(
                            Icons.help,
                            size: 22,
                            color: Colors.greenAccent,
                          ),
                          txt: Text(
                            'App Info',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          )),
                    ),
                    Divider(
                      color: Colors.black38,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Contact()));
                      },
                      child: listBuilder(
                          ico: Icon(
                            Icons.message,
                            size: 22,
                            color: Colors.greenAccent,
                          ),
                          txt: Text(
                            'Contact us',
                            style: TextStyle(fontSize: 22),
                          )),
                    ),
                    // Divider(
                    //   color: Colors.black12,
                    // ),
                    // listBuilder(
                    //     ico: Icon(
                    //       Icons.star,
                    //       size: 22,
                    //       color: Colors.greenAccent,
                    //     ),
                    //     txt: Text(
                    //       'Rate us',
                    //       style: TextStyle(fontSize: 22),
                    //     )),
                    // Divider(
                    //   color: Colors.black12,
                    // ),
                    // listBuilder(
                    //     ico: Icon(
                    //       Icons.share,
                    //       size: 22,
                    //       color: Colors.greenAccent,
                    //     ),
                    //     txt: Text(
                    //       'Share',
                    //       style: TextStyle(fontSize: 22),
                    //     )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _auth.signOut().whenComplete(() => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage())));
                },
                child: Container(
                  color: Colors.white,
                  child: listBuilder(
                      ico: Icon(
                        Icons.exit_to_app,
                        size: 22,
                        color: Colors.greenAccent,
                      ),
                      txt: Text(
                        'Log out',
                        style: TextStyle(fontSize: 22),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
