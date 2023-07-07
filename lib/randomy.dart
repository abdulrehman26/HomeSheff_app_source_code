import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/signout.dart';


class HomeScreen21 extends StatefulWidget {
  final String getemail;

  HomeScreen21({required this.getemail});
  @override
  _HomeScreen21State createState() => _HomeScreen21State();
}

class _HomeScreen21State extends State<HomeScreen21> {
  int _currentIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    ProfilePage(),
    SignOutScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9161AB),
        centerTitle: true,
        title: Text('${widget.getemail}',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 400),
        height: 55,
        buttonBackgroundColor: Color(0xffD6E2EA),
        color: Color(0xff9161AB),
        backgroundColor: Color(0xfffafafa),
        items: [
          Icon(Icons.home, size: 30),
          Icon(Icons.chat, size: 30),
          Icon(Icons.person, size: 30),
          Icon(Icons.settings, size: 30),

        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page', style: TextStyle(fontSize: 24)),
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
    return Center(
      child: Text('Profile Page ', style: TextStyle(fontSize: 24)),
    );
  }
}