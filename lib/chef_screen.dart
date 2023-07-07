import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/chat_module.dart';
import 'package:login/chef_signout.dart';
import 'package:login/signout.dart';

import 'appdrawer.dart';
import 'crusor_slider.dart';
import 'expanded.dart';


class HomeScreen21 extends StatefulWidget {
  final String getemail;

  HomeScreen21({required this.getemail});
  @override
  _HomeScreen21State createState() => _HomeScreen21State();
}

class _HomeScreen21State extends State<HomeScreen21> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  bool _isSearchBarActive = false;
  void showNoNotificationsAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Notifications'),
          content: Text('There are no new notifications at the moment.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _onSearchTextChanged(String value) {
    // Handle search query changes
  }

  void _onSearchSubmitted(String value) {
    // Handle search submission
  }
  void _searchPressed() {
    setState(() {
      _isSearchBarActive = !_isSearchBarActive;
      if (!_isSearchBarActive) {
        _searchController.clear();
      }
    });
  }
  int _currentIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    ChatModule(),
    AddPage(),
    ProfilePage(),
    SignOutScreen22(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Color(0xff9161AB),
          centerTitle: true,
          title: _isSearchBarActive
              ? TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white70),
            ),
            onChanged: _onSearchTextChanged,
            onSubmitted: _onSearchSubmitted,
          )
              : Text(
            '${widget.getemail}',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(_isSearchBarActive ? Icons.close : Icons.search),
              onPressed: _searchPressed,
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                showNoNotificationsAlert();
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 400),
        height: 55,
        color: Color(0xff9161AB),
        backgroundColor: Color(0xffD6E2EA),
        items: [
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(Icons.chat, size: 30,color: Colors.white,),
          Icon(Icons.add, size: 30,color: Colors.white,),
          Icon(Icons.person, size: 30,color: Colors.white,),
          Icon(Icons.settings, size: 30,color: Colors.white,),

        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: AppDrawer(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CursorSlider(),
            //  SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FixedSizeContainerExample(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chat Page', style: TextStyle(fontSize: 24)),
    );
  }
}
class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: Center(
        child: Text('Add Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
class Settingspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Setting Page', style: TextStyle(fontSize: 24)),
    );
  }
}
class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: Center(
        child: Text('Profile Page ', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}