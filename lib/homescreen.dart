import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/chat_module.dart';
import 'package:login/settings_page.dart';
import 'package:login/signout.dart';

import 'appdrawer.dart';
import 'checker.dart';
import 'crusor_slider.dart';
import 'expanded.dart';

class HomeScreen extends StatefulWidget {
  final String getemail;

  HomeScreen({required this.getemail});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  bool _isSearchBarActive = false;

  void _searchPressed() {
    setState(() {
      _isSearchBarActive = !_isSearchBarActive;
      if (!_isSearchBarActive) {
        _searchController.clear();
      }
    });
  }

  void _onSearchTextChanged(String value) {
    // Handle search query changes
  }

  void _onSearchSubmitted(String value) {
    // Handle search submission
  }
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

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      _updateIconColors();
    });
  }

  void _updateIconColors() {
    setState(() {
      _iconColors = List.generate(
        _icons.length,
        (index) => index == _currentIndex ? Colors.black : Colors.white,
      );
    });
  }

  int _currentIndex = 0;
  List<IconData> _icons = [
    Icons.home,
    Icons.chat,
    Icons.settings,
  ];
  List<Color> _iconColors = [
    Colors.white, // Home icon color
    Colors.white, // Chat icon color
    Colors.white, // Settings icon color
  ];
  List<Widget> _pages = [
    HomePage(),
    ChatModule(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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

        color: Color(0xff9161AB),
        backgroundColor: Color(0xffD6E2EA),

        height: 55,
        items: [
          Icon(Icons.home, color: Colors.white,),
          Icon(Icons.chat, color: Colors.white,),
          Icon(Icons.settings, color: Colors.white,),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: AppDrawer(),
    ));
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
