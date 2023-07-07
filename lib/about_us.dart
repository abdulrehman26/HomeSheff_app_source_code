import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9161AB),
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to our mobile application. We are a team of dedicated professionals committed to providing you with a seamless and user-friendly experience. Our mission is to deliver innovative solutions that enhance your daily life.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Vision',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'At HomeSheff, we strive to be a leading provider of cutting-edge technology solutions. We aim to create products that simplify and enrich the lives of our users, making their digital experience enjoyable and efficient.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Values',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '1. Innovation: We are passionate about pushing boundaries and constantly exploring new ideas to deliver the best possible experience to our users.\n\n'
                  '2. User-Centric Approach: Our users are at the center of everything we do. We value their feedback and insights to continuously improve our products and services.\n\n'
                  '3. Quality and Reliability: We are committed to delivering high-quality, reliable, and secure solutions that exceed user expectations.\n\n'
                  '4. Transparency: We believe in open and honest communication with our users, providing clear information about our products, updates, and any changes.\n\n'
                  '5. Privacy and Security: We prioritize the privacy and security of our users\' data, implementing robust measures to safeguard their information.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'If you have any questions, suggestions, or concerns, please feel free to reach out to us. We value your feedback and are here to assist you.',
            ),
            Text(
              'Thank you for choosing HomeSheff. We appreciate your support!',
            ),

            // Add more text as needed
          ],
        ),
      ),
    );
  }
}
