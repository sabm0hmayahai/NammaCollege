import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
//import 'constants.dart';

//PAGE3
class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final db = Firestore.instance;
  File sampleImage = File('');
  String userEmail = "";

  @override
  initState() {
    super.initState();
    doAsyncStuff();
  }

  doAsyncStuff() async {
    FirebaseUser name = await FirebaseAuth.instance.currentUser();
    userEmail = name.email;
    var firstName = userEmail.split('@');

    setState(() {
      userEmail = firstName[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0, 0.5, 0.7, 0.9], //fade, reach,
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.red,
              Colors.black,
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: new Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                    Center(
                        child: Text(
                          'Hello! 🙋🏻‍♂️',
                          textScaleFactor: 2,
                          style: TextStyle(fontWeight: FontWeight.normal),
                          textAlign: TextAlign.justify,
                        )),
                new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                      '$userEmail',
                      textScaleFactor: 2,
                      style: TextStyle(fontWeight: FontWeight.w800),
                      textAlign: TextAlign.justify,
                    )),
                  ),

                new Container(
                  height: 180.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color giveSplashColor() {
  var now = new DateTime.now();
  int r, g, b;
  var rng = new Random(now.millisecondsSinceEpoch);
  r = rng.nextInt(255);
  g = rng.nextInt(255);
  b = rng.nextInt(255);
  Color culor = new Color.fromRGBO(r, g, b, 1.0);
  return culor;
}
