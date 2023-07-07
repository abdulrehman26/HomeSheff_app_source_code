import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/about_us.dart';
import 'package:login/homescreen.dart';

import 'cart.dart';

class Darwer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(

          title: Text('My App'),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: AppDrawer(),
        // Rest of your app content...
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff9161AB),
            ),
            child: Center(
              child: Text(
                'Home Sheff',
                style: GoogleFonts.actor(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1, 1), // Adjust the values to control the shadow position
                      blurRadius: 4, // Adjust the value to control the blurriness of the shadow
                    ),
                  ],
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(getemail: '')));
              // Handle Home tile onTap here
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Your Cart'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));
              // Handle Home tile onTap here
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()));
              // Handle Home tile onTap here
            },
          ),
        ],
      ),
    );
  }
}
