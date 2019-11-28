import 'package:flutter/material.dart';
import 'auth.dart';
import 'homeFeed.dart';
import 'profilePage.dart';
import 'askQuestion.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }

  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');
  final Key keyThree = PageStorageKey('pageThree');

  HomePage1 one;
  //QuestionAnswer two;
  FirestoreCRUDPage two;
  ProfilePage three;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    one = HomePage1(
      key: keyOne,
    );
    two = FirestoreCRUDPage(
      key: keyTwo,
    );
    three = ProfilePage(
      key: keyThree,
    );

    pages = [one, two, three];
    currentPage = one;
    super.initState();
  }

  // List<Data> dataList;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: new PageStorage(
        bucket: bucket,
        child: currentPage,
      ),
      floatingActionButton: Align(
        child: FloatingActionButton(
            child: Icon(Icons.exit_to_app),
            foregroundColor: Colors.grey[700],
            backgroundColor: Color.fromARGB(200, 34, 35, 39),
            onPressed: _signOut),
        alignment: Alignment(1, 1),
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color.fromARGB(200, 34, 35, 39),
          splashColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(
                  color: Colors.grey[
                      700])), // sets the inactive color of the `BottomNavigationBar`
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.dvr), // school
                ),
                title: Text(
                    'Home')), //, style: TextStyle(color: Colors.lightGreen)
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.chat_bubble_outline),
                ),
                title: Text('Ask')),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.more_horiz),
                ),
                title: Text('More')),
          ],
          currentIndex: selectedIndex,
          fixedColor: giveColor(selectedIndex),
          iconSize: 24, // ICON SIZE
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      currentPage = pages[index];
    });
  }
}

Color giveColor(int x) {
  if (x == 0) {
    Color clr = new Color(0xFF64B5F6);
    return clr;
  } else if (x == 1) {
    Color clr = new Color(0xFF4DB6AC);
    return clr;
  } else {
    Color clr = new Color(0xFFE57373);
    return clr;
  }
}
