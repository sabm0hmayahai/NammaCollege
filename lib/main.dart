import 'package:flutter/material.dart';
import 'auth.dart';
import 'root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Namma College',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          accentColor: Colors.white,
          fontFamily: 'Google'),
      home: new RootPage(auth: new Auth()),
    );
  }
}
