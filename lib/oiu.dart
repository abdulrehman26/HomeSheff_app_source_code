import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen0 extends StatefulWidget {
  @override
  _HomeScreen0State createState() => _HomeScreen0State();
}

class _HomeScreen0State extends State<HomeScreen0> {
  int _currentIndex = 0;
  List<IconData> _icons = [
    Icons.home,
    Icons.chat,
    Icons.settings,
  ];
  List<Color> _iconColors = [
    Colors.black,
    Colors.white,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 400),
              height: 55,
              buttonBackgroundColor: Color(0xfffafafa),
              color: Color(0xFF11253d),
              backgroundColor: const Color(0xffD6E2EA),
              items: _icons
                  .asMap()
                  .map(
                    (index, icon) => MapEntry(
                  index,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                        _updateIconColors();
                      });
                    },
                    child: Icon(
                      icon,
                      color: _iconColors[index],
                      size: 30,
                    ),
                  ),
                ),
              )
                  .values
                  .toList(),
              onTap: (index) {},
            ),
          ),
        ],
      ),
    );
  }

  void _updateIconColors() {
    setState(() {
      _iconColors = List.generate(
        _icons.length,
            (index) => index == _currentIndex ? Colors.black : Colors.white,
      );
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen0(),
  ));
}
