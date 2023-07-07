import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/loginscreen.dart';
import 'package:login/signup.dart';
import 'package:login/signup_phone.dart';
import 'login_chef.dart';

class BeforeCredentials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image01.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text('Welcome',
                      style: GoogleFonts.oxygen(
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2,
                                  2), // Adjust the values to control the shadow position
                              blurRadius:
                                  8 // Adjust the value to control the blurriness of the shadow
                              ),
                        ],
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ))),
              Align(
                  alignment: Alignment.center,
                  child: Text('To Homemade Meals!',
                      style: GoogleFonts.oxygen(
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2,
                                  2), // Adjust the values to control the shadow position
                              blurRadius:
                                  8 // Adjust the value to control the blurriness of the shadow
                              ),
                        ],
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ))),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.75),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUpPhone()));

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height *
                            0.15, // Set the height of the container
                        decoration: BoxDecoration(
                          color: Colors
                              .blue, // Set the background color of the container
                          borderRadius: BorderRadius.circular(
                              10), // Set the border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.5), // Set the shadow color
                              spreadRadius: 1, // Set the spread radius
                              blurRadius: 2, // Set the blur radius
                              offset: Offset(1, 1), // Set the offset
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10), // Clip the child with the same border radius
                          child: Image.asset(
                            'assets/Chef hat with spoon and fork logo design(6).png', // Replace with your own image path
                            fit: BoxFit.cover, // Adjust the image fit as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height *
                            0.15, // Set the height of the container
                        decoration: BoxDecoration(
                          color: Colors
                              .blue, // Set the background color of the container
                          borderRadius: BorderRadius.circular(
                              10), // Set the border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.5), // Set the shadow color
                              spreadRadius: 1, // Set the spread radius
                              blurRadius: 2, // Set the blur radius
                              offset: Offset(1, 1), // Set the offset
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10), // Clip the child with the same border radius
                          child: Image.asset(
                            'assets/Chef hat with spoon and fork logo design(7).png', // Replace with your own image path
                            fit: BoxFit.cover, // Adjust the image fit as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(

                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    // Handle "Sign In" button tap
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                    // Set overlayColor to transparent to remove the shadow
                  ),
                  child: Text('Sign In Customer',
                    style: GoogleFonts.varelaRound(fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2), // Adjust the values to control the shadow position
                          blurRadius: 4, // Adjust the value to control the blurriness of the shadow
                        ),
                      ],
                    ),

                  ),
                ),
                SizedBox(width: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreenq(phoneNumber: '', password2: '',)));
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  child: Text('Sign In Chef',
                    style: GoogleFonts.varelaRound(fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


