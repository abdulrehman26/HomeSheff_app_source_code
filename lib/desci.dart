import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'expanded.dart';
import 'meal.dart';

class ChefProfilePage extends StatelessWidget {
  final String name;
  const ChefProfilePage( this.name, {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chef Profile'),
        backgroundColor: Color(0xff9161AB),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/prfily.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
           // SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                name,
                style: GoogleFonts.oxygen(
                  color: Colors.black,
                  fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
           // SizedBox(height: 5.0),
            MealSuggestions(),
          //  SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.call,
                    size: 20.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Contact Number:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '       0343 4822405',
                    style: TextStyle(
                      fontSize: 16.0,
                     // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Chef Profile Container')),
      body: Center(
        child: ChefContainer(),
      ),
    ),
  ));
}