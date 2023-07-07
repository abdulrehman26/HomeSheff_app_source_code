import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/signup.dart';
import 'package:lottie/lottie.dart';
import 'homescreen.dart';
import 'loginscreen.dart';
import 'navtocredentials.dart';

// void main() {
//   runApp(OnboardingApp());
// }
//
//
// class OnboardingApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Onboarding App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: OnboardingScreen(),
//     );
//   }
// }

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List colors = const [
    Color(0xff9161AB),
    Color(0xff9161AB),
    Color(0xff9161AB),
  ];
  List<Widget> _onboardingScreens = [
    OnboardingPage(
      title: 'Welcome to Home Sheff',
      subtitle: 'Delicious, Healthy, and Convenient',
      description: "Discover a new way to enjoy homemade meals while you're away from home.",
      lottiepath: 'assets/126364-cooking.json',
    ),
    OnboardingPage(
      title: 'Explore a Variety of Dishes',
      subtitle: 'Satisfy Your Cravings',
      description: "Browse through a diverse range of mouthwatering dishes prepared with love and care.",
      //imagePath: 'assets/log.png',
      lottiepath: 'assets/body.json',
    ),
    OnboardingPage(
      title: 'Convenient Meal Delivery',
      subtitle: 'Order Anytime, Anywhere',
      description: "Place your orders with ease and have your homemade meals delivered straight to your doorstep.",
     // imagePath: 'assets/log.png',
      lottiepath: 'assets/21652-delivery-guy-waiting.json',
    ),
  ];

   _navigateToBeforeCredentials() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BeforeCredentials()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _onboardingScreens,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: Text(
                      _currentPage == _onboardingScreens.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                    onPressed: _currentPage == _onboardingScreens.length - 1
                        ? _navigateToBeforeCredentials
                        : () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),

                      backgroundColor: Color(0xFF11253d),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    return List<Widget>.generate(
      _onboardingScreens.length,
          (index) {
        final double selectedSize = 12.0;
        final double unselectedSize = 8.0;
        final Color selectedColor = Colors.white;
        final Color unselectedColor = Colors.grey.shade500;

        final bool isSelected = _currentPage == index;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          width: isSelected ? selectedSize : unselectedSize,
          height: isSelected ? selectedSize : unselectedSize,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        );
      },
    );
  }

}



class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  //final String imagePath;
  final String lottiepath;


  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    //required this.imagePath,
    required this.lottiepath,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              ),
              child: Lottie.asset(lottiepath,),
          ),
          //Image.asset(imagePath),
          SizedBox(height: 32.0),
          Text(textAlign: TextAlign.center,
            title,
            style: GoogleFonts.lato(
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
          SizedBox(height: 16.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.oxygen(
              color: Colors.white70,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1, 1), // Adjust the values to control the shadow position
                  blurRadius: 5, // Adjust the value to control the blurriness of the shadow
                ),
              ],
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      ),
    );
  }
}


