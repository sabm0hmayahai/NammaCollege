import 'auth.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Singed in: $userId');
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e ');
      }
    }
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      body: new SizedBox(
        child: new SingleChildScrollView(
          child: DecoratedBox(
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Colors.purple[700],
                  Colors.indigo[600],
                  Colors.indigo[500],
                  Colors.blue[700],
                ],
              ),
            ),
            child: Center(
              child: new Container(
                  //color: Colors.grey[800],
                  padding: EdgeInsets.all(18.0),
                  child: new Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: logo() + propaganda()+  buildInputs() + buildButtons(),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> propaganda(){
    return [
      Padding(
        padding: const EdgeInsets.only(bottom:16.0),
        child: new Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: "made with ♥️︎",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    ];
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new TextFormField(
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
                labelText: '  Email',
                hintText: '   Enter your email',
                labelStyle: new TextStyle(color: Colors.grey, fontSize: 16.0)),
            style: TextStyle(color: Colors.white),
            validator: (value) => !value.contains('@') ? 'Invalid email' : null,
            onSaved: (value) => _email = value,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
          child: new TextFormField(
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
                hintText: '   Enter your password',
                labelText: '  Password',
                labelStyle: new TextStyle(color: Colors.grey, fontSize: 16.0)),
            style: TextStyle(color: Colors.white),
            obscureText: true,
            validator: (value) => value.length < 6
                ? 'Account doesn\'t exist or Incorrect password'
                : null,
            onSaved: (value) => _password = value,
          ),
        ),
      ];
    } else {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new TextFormField(
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
                labelText: '  Email',
                hintText: '   Your email ID',
                labelStyle: new TextStyle(color: Colors.grey, fontSize: 16.0)),
            style: TextStyle(color: Colors.white),
            validator: (value) => !value.contains('@') || value.length > 30 ? 'Invalid email' : null,
            onSaved: (value) => _email = value,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
          child: new TextFormField(
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
                labelText: '  Password',
                hintText: '   Keep a strong password',
                labelStyle: new TextStyle(color: Colors.grey, fontSize: 16.0)),
            style: TextStyle(color: Colors.white),
            obscureText: true,
            validator: (value) =>
                value.length < 6 ? 'Password too short (atleast 6 char)' : null,
            onSaved: (value) => _password = value,
          ),
        ),
      ];
    }
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        SizedBox(
          height: 50.0,
          width: double.infinity,
          child: new RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20)),
            color: Colors.white,
            elevation: 4.0,
            splashColor: giveSplashColor(),
            onPressed: validateAndSubmit,
            child: RichText(
              text: TextSpan(
                text: 'Log In ',
                style: TextStyle(
                  color: Colors.black,
                  decorationStyle: TextDecorationStyle.wavy,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        new FlatButton(
          child: new Text('Don\'t have an account? Sign Up',
              style: new TextStyle(fontSize: 17.0)),
          onPressed: moveToRegister,
        ),
        new Container(
          height: 300,
        ),
      ];
    } else {
      return [
        SizedBox(
          height: 50.0,
          width: double.infinity,
          child: new RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20)),
            color: Colors.white,
            elevation: 4.0,
            splashColor: giveSplashColor(),
            onPressed: validateAndSubmit,
            child: RichText(
              text: TextSpan(
                text: 'Sign Up ',
                style: TextStyle(
                  color: Colors.black,
                  decorationStyle: TextDecorationStyle.wavy,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        new FlatButton(
          child: new Text('Have an account? Login',
              style: new TextStyle(fontSize: 17.0)),
          onPressed: moveToLogin,
        ),
        new Container(
          height: 300,
        ),
      ];
    }
  }

  List<Widget> logo() {
    return [
      new Container(
        height: 80.0,
      ),
      Image.asset(
        'assets/mainlogo.png',
        width: 80.0,
        height: 180.0,
      ),
      new Container(
        height: 20.0,
      ),
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
