import 'package:flutter/material.dart';

void main() => runApp(DarkLight());

class DarkLight extends StatefulWidget {
  @override
  _DarkLightState createState() => _DarkLightState();
}

class _DarkLightState extends State<DarkLight> {
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dark/Day Mode'),
        ),
        body: Container(
          color: isDarkMode ? Colors.black : Colors.white,
          child: Center(
            child: ElevatedButton(
              onPressed: toggleDarkMode,
              child: Text(
                isDarkMode ? 'Switch to Day Mode' : 'Switch to Dark Mode',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
