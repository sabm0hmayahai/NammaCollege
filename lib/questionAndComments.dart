import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:date_format/date_format.dart';
//PAGE1 INSIDE NAVIGATION

class QuestionAnswer extends StatefulWidget {
  String question;
  String subject;
  String userEmail;
  String time;
  DocumentSnapshot doc;

  QuestionAnswer(String sPassed, String qPassed, String userEmailPassed,
      String timeDate, DocumentSnapshot docPassed) {
    subject = sPassed;
    question = qPassed;
    doc = docPassed;
    userEmail = userEmailPassed;
    time = timeDate;
  }

  @override
  _QuestionAnswer createState() =>
      _QuestionAnswer(subject, question, userEmail, time, doc);
}

class _QuestionAnswer extends State<QuestionAnswer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();

  String id;
  String email;
  String question;
  String subject;
  String questionFromDSnapshot;
  String userEmail;
  String time;
  DocumentSnapshot doc;

  @override
  initState() {
    super.initState();
    doAsyncStuff();
  }

  doAsyncStuff() async {
    FirebaseUser name = await FirebaseAuth.instance.currentUser();
    email = name.email;
    var firstName = email.split('@');
    var now = new DateTime.now();
    final timeNow =
        formatDate(now, [dd, '/', mm, '/', yy, ' at ', HH, ':', nn]);

    setState(() {
      email = firstName[0];
      time = timeNow;
    });
  }

  _QuestionAnswer(String passTwoS, String passTwoQ, String userEmailPassedtwo,
      String timeDate, DocumentSnapshot docPassed) {
    doc = docPassed;
    question = passTwoQ;
    subject = passTwoS;
    userEmail = userEmailPassedtwo;
    time = timeDate;
  }

  _onClear() {
    _textFieldController.text = "";
  }

  kitnaHeight(DocumentSnapshot doc) {
    var baccha = "${doc.data['comment']}";
    var len = baccha.length;
    var n = len / 36;
    if (len < 37) return 87.0;

    return 83.0 + (n * 20);
  }

  Widget buildAnswer(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new SizedBox(
        height: kitnaHeight(doc),
        width: double.infinity,
        child: new RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            color: gradCol.withOpacity(0.3),
            elevation: 8.0,
            splashColor: giveSplashColor(),
            onPressed: () {},
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.bottomLeft,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                            child: RichText(
                              text: TextSpan(
                                text: ' ${doc.data['ansUser']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                      devHoKya(doc.data['ansUser']),
                    ],
                  ),
                ),
                new Container(
                  height: 10,
                ),
                new Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: "${doc.data['comment']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                  ),
                ),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 4.0, top: 4.0, bottom: 4.0),
                          child: RichText(
                            text: TextSpan(
                              text: '${doc.data['time']}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Container(
                  height: 5,
                ),],
            )),
      ),
    );
  }

  final db = Firestore.instance;

  Color gradCol = giveSplashColor();
  String answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0, 0.5, 0.7, 0.9], //fade, reach,
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                gradCol,
                Colors.black,
                Colors.black,
                Colors.black,
              ],
            ),
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          new Align(
                            alignment: Alignment.topLeft,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 4.0,
                                    bottom: 4.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: ' ${doc.data['user']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          devHoKya(doc.data['user']),
                          branchKyaHaiBhai(doc),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            text: "${doc.data['subject']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            text: "${doc.data['name']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Align(
                        alignment: Alignment.bottomLeft,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            //color: Colors.white,
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 8.0, top: 4.0, bottom: 4.0),
                            child: RichText(
                              text: TextSpan(
                                text: ' ${doc.data['time']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: buildTextFormField() + buildPostButton(),
                        ),
                      )),
                  StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection('CRUD')
                        .document(doc.documentID)
                        .collection('ANSWER')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if ('$doc.data[\'answer\']' != 'null')
                          return Column(
                              children: snapshot.data.documents
                                  .map((doc) => buildAnswer(doc))
                                  .toList());
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  new Container(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget devHoKya(var username) {
    if (username == 'mukherjeekalpan' || username == 'rajeshhegde180') {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: new Align(
          alignment: Alignment.topLeft,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
              child: RichText(
                text: TextSpan(
                  text: 'dev',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
    } else
      return new Container();
  }

  Widget branchKyaHaiBhai(DocumentSnapshot doc) {
    if (doc.data['branch'] != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: new Align(
          alignment: Alignment.bottomRight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
              child: RichText(
                text: TextSpan(
                  text: doc.data['branch'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
    } else
      return new Container();
  }

  void createData() async {
    String ans = _textFieldController.text;
    print(ans);
    //await db.collection('CRUD').document(doc.documentID).delete();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('CRUD')
          .document(doc.documentID)
          .collection('ANSWER')
          .add({'comment': '$ans ', 'ansUser': '$email', 'time': '$time'});
      //.add({'name': '$ans '})
      // setState(() => id = ref.documentID);
      // print(ref.documentID);
    }
  }

  List<Widget> buildPostButton() {
    return [
      new Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: new RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 4.0,
            splashColor: giveSplashColor(),
            onPressed: createData,
            child: RichText(
              text: TextSpan(
                text: ' Comment ',
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
      )
    ];
  }

  List<Widget> buildTextFormField() {
    return [
      new TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: _textFieldController,
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
              labelText: 'Answer',
              hintText: '  Write your answer here',
              labelStyle: new TextStyle(color: Colors.grey, fontSize: 16.0)),
          maxLines: 2,
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
                      title: const Text('Thanks for answering',
                          style: TextStyle(color: Colors.lightGreen)),
                      content: const Text(
                          'You have successfully posted your answer',
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
          })
    ];
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
