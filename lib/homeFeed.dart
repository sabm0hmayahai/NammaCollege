import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'questionAndComments.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

//PAGE1
class HomePage1 extends StatefulWidget {
  const HomePage1({Key key}) : super(key: key);

  @override
  _HomePage1 createState() => _HomePage1();
}

class _HomePage1 extends State<HomePage1> {
  final db = Firestore.instance;
  String userEmail = "";

  findTheUserName() async {
    FirebaseUser name = await FirebaseAuth.instance.currentUser();
    userEmail = name.email;
    var firstName = userEmail.split('@');

    setState(() {
      userEmail = firstName[0];
    });

    //return userEmail;
  }

  Widget buildQuestion(DocumentSnapshot doc) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
      child: new SizedBox(
        height: 120.0,
        width: double.infinity,
        child: new RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            color: Colors.blueAccent.withOpacity(0.4),
            elevation: 8.0,
            splashColor: giveSplashColor(),
            onPressed: () {
              String subject = '${doc.data['subject']}';
              String question = '${doc.data['name']}';
              String userEmail = '${doc.data['user']}';
              String time = '${doc.data['time']}';
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionAnswer(
                        subject, question, userEmail, time, doc)),
              );
            },
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 10,
                ),
                new Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: "${doc.data['subject']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                new Container(
                  height: 5,
                ),
                new Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: '${doc.data['name']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Container(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: new Row(
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.bottomRight,
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
                      devHoKya(doc),
                      //branch tag
                      branchKyaHaiBhai(doc),
                      new Container(
                        width: 20,
                      ),

                      new Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 2.0, right: 2.0, top: 2.0, bottom: 2.0),
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
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
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

  Widget devHoKya(DocumentSnapshot doc) {
    if (doc.data['user'] == 'mukherjeekalpan' ||
        doc.data['user'] == 'rajeshhegde180') {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: new Align(
          alignment: Alignment.bottomRight,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
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
                Colors.blueAccent,
                Colors.black,
                Colors.black,
                Colors.black,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 0.0,
              bottom: 0.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        ' Timeline 📰',
                        textScaleFactor: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection('CRUD')
                        .orderBy('time2', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                            children: snapshot.data.documents
                                .map((doc) => buildQuestion(doc))
                                .toList());
                      } else {
                        return SizedBox();
                      }
                    },
                  )
                ],
              ),
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
