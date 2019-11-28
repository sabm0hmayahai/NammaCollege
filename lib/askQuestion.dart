import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:date_format/date_format.dart';

//PAGE2
class FirestoreCRUDPage extends StatefulWidget {
  const FirestoreCRUDPage({Key key}) : super(key: key);

  @override
  FirestoreCRUDPageState createState() {
    return FirestoreCRUDPageState();
  }
}

class FirestoreCRUDPageState extends State<FirestoreCRUDPage> {
  String id;
  String userEmail = "";
  String time = "";
  String time2 = "";
  String question;
  String subject;
  String branch = "Others";

  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController15 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  String _currentSelectedValue;

  _onClear() {
    setState(() {
      _textFieldController1.text = "";
      _textFieldController15.text = "";
      _textFieldController2.text = "";
      _currentSelectedValue = null;
    });
  }

  @override
  initState() {
    super.initState();
    doAsyncStuff();
  }

  doAsyncStuff() async {
    FirebaseUser name = await FirebaseAuth.instance.currentUser();
    userEmail = name.email;
    var firstName = userEmail.split('@');
    var now = new DateTime.now();
    final timeNow =
        formatDate(now, [dd, '/', mm, '/', yy, ' at ', HH, ':', nn]);
    final timeNowForOrder = formatDate(now, [yy, mm, dd, HH, nn]);
    //print(time);
    setState(() {
      userEmail = firstName[0];
      time = timeNow;
      time2 = timeNowForOrder;
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
              Colors.teal,
              Colors.black,
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: new Container(
              //color: Colors.grey[800],
              padding: EdgeInsets.all(18.0),
              child: new Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: buildTextFormField() + buildPostButton(),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  List<Widget> buildTextFormField() {
    return [
      new Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Text(
            'Ask Question 🤔',
            textScaleFactor: 2,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
      new Container(
        height: 10,
      ),
      FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                fillColor: Colors.black.withOpacity(0.5),
                filled: true,
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                  borderSide: new BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                )
            ),
            isEmpty: _currentSelectedValue == null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectedValue,
                hint: Text('  What is it related to?\n  (Select from dropdown)'),
                onChanged: (String newValue) {
                  setState(() {
                    _currentSelectedValue = null;
                    _currentSelectedValue = newValue;
                    branch = newValue;
                    state.didChange(newValue);
                  });
                },
                items: <String>[
                  "Transport",
                  "Fees",
                  "Staff",
                  "ISE",
                  "CSE",
                  "ECE",
                  "MECH",
                  "Others"
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
      new Container(
        height: 10.0,
      ),
      new TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: _textFieldController1,
          decoration: InputDecoration(
              fillColor: Colors.black.withOpacity(0.5),
              filled: true,
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: new BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
              ),
              labelText: '  Subject',
              hintText: '  Give a short title / subject ',
              labelStyle: new TextStyle(color: Colors.grey, fontSize: 16.0)),
          maxLines: 1,
          validator: (value) {
            if (value.isEmpty) {
              return ' Please enter some text';
            }
          },
          onSaved: (value) {
            subject = value;
          }),
      new Container(
        height: 10.0,
      ),
      new TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: _textFieldController2,
          decoration: InputDecoration(
              fillColor: Colors.black.withOpacity(0.5),
              filled: true,
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: new BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
              ),
              labelText: '  Ask something',
              hintText: '  What\'s on your mind?',
              labelStyle: new TextStyle(color: Colors.grey, fontSize: 16.0)),
          maxLines: 3,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          onSaved: (value) {
            question = value;
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Posted! 😄',
                          style: TextStyle(color: Colors.lightGreen)),
                      content: const Text(
                          'You made it ! \nCheck out homepage ',
                          style: TextStyle(color: Colors.white70)),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new RaisedButton(
                            color: Colors.lightGreen,
                            elevation: 4.0,
                            splashColor: Colors.white70,
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Done',
                                style: TextStyle(
                                  color: Colors.black,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
            _onClear();
          }),
      new Container(
        height: 10.0,
      ),
    ];
  }

  List<Widget> buildPostButton() {
    return [
      new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new SizedBox(
          width: 150.0,
          height: 50.0,
          child: new RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20)),
            color: Colors.white,
            elevation: 4.0,
            splashColor: giveSplashColor(),
            onPressed: () {
              createData();
            },
            child: RichText(
              text: TextSpan(
                text: ' Post ',
                style: TextStyle(
                  color: Colors.black,
                  decorationStyle: TextDecorationStyle.wavy,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db.collection('CRUD').add({
        'name': '$question ',
        'subject': '$subject ',
        'user': '$userEmail',
        'time2': '$time2',
        'time': '$time',
        'branch': '$branch'
      });
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
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
