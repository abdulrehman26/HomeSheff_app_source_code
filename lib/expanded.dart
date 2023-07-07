import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'desci.dart';

class FixedSizeContainerExample extends StatefulWidget {
  @override
  _FixedSizeContainerExampleState createState() =>
      _FixedSizeContainerExampleState();
}

class _FixedSizeContainerExampleState extends State<FixedSizeContainerExample> {
  bool _showAdditionalContainers = false;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Find Your Favorite Chef',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oxygen(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        offset: Offset(1, 1), // Adjust the values to control the shadow position
                        blurRadius: 5, // Adjust the value to control the blurriness of the shadow
                      ),
                    ],
                  ),

                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFF11253d),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.transparent; // Set the color when pressed
                            }
                            return Colors.transparent; // Use the default color
                          },)),
                    onPressed: () {
                      setState(() {
                        _showAdditionalContainers = !_showAdditionalContainers;
                      });
                    },
                     child: Text(_showAdditionalContainers ? 'Hide' : 'View More',
                      style: GoogleFonts.oxygen(
                        color: Colors.white,
                        fontSize: 10.0,
                        backgroundColor: Color(0xFF11253d),

                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
            Column(
              children: [
                Row(
                  children: const [
                    Conat(name: 'Salman Shahid', profileimage: 'assets/6.jpg',),
                    SizedBox(width: 8,),
                    Conat(name: 'Ahmad Raza', profileimage: 'assets/4.jpg',),

                  ],
                ),const SizedBox(height: 8,),
                Row(
                  children: const [
                    Conat(name: 'Amina Siddique', profileimage: 'assets/5.png',),
                    SizedBox(width: 8,),
                    Conat(name: 'Khatija Ali', profileimage: 'assets/1.jpg'),

                  ],
                ),
              ],
            ),
            SizedBox(height: 8,),
            if (_showAdditionalContainers) ...[
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Conat(name: 'Aliza Shiekh', profileimage: 'assets/333.jpg',),
                      SizedBox(width: 8,),
                      Conat(name: 'Fatima Amjad', profileimage: 'assets/8.jpg',),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
    );
  }
}

class Conat extends StatelessWidget {
  final name;
  final profileimage;
  const Conat({Key? key, this.name, this.profileimage, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChefProfilePage(name)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.teal.shade300,
            width: MediaQuery.of(context).size.width / 2 - 20.0,
            height: 200 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage(profileimage),
              ),
              SizedBox(height: 10.0),
              Text(
                name,
                style: GoogleFonts.oxygen(
                  color: Colors.white,
                  fontSize: 15.0,
                //  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
            ],
          ),
        ),
        // Container(
        //   width: MediaQuery.of(context).size.width / 2 - 20.0,
        //   height: MediaQuery.of(context).size.height / 4,
        //   child: Image.asset('assets/bg 2.jpg',
        //   fit: BoxFit.cover,
        //   ),
        //   //margin: EdgeInsets.all(8.0),
        // ),
      ),
    );
  }
}


class ChefContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 250.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('assets/chef_profile.jpg'),
          ),
          SizedBox(height: 10.0),
          Text(
            'Chef Name',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }
}

