import 'package:flutter/material.dart';
import 'dart:async';

class CursorSlider extends StatefulWidget {
  @override
  _CursorSliderState createState() => _CursorSliderState();
}

class _CursorSliderState extends State<CursorSlider> {
  int _currentIndex = 0;
  List<String> _imageUrls = [
    'assets/banner_01.jpg',
    'assets/banner_02.jpg',
    'assets/banner_03.jpg',
  ];
  late Timer _timer;
  final _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _imageUrls.length;
      });
      _controller.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.0,

      child: PageView.builder(
        controller: _controller,
        itemCount: _imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              double value = 1.0;
              if (_controller.position.haveDimensions) {
                value = _controller.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * 150,
                  width: Curves.easeInOut.transform(value) * 300, // Update width here
                  child: child,
                ),
              );
            },
            child: Container(

              width: MediaQuery.of(context).size.width, // Update width here
              decoration: BoxDecoration(
               // borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: _currentIndex == index ? Colors.transparent : Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  _imageUrls[index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
