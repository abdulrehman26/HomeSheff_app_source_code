import 'package:flutter/material.dart';

class PrivacyAndPoliciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9161AB),
        title: Text('Privacy and Policies'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Your privacy is important to us. This Privacy Policy explains how we collect, use, and disclose your personal information when you use our mobile application.',
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Information Collection',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We may collect personal information that you provide to us, such as your name, email address, and profile picture. We may also collect certain non-personal information, such as device information and usage data.',
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Information Use',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We may use the collected information for various purposes, including to provide and improve our services, communicate with you, personalize your experience, and comply with legal obligations.',
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Information Sharing',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We may share your personal information with third-party service providers who assist us in operating our application and providing services to you. We may also disclose your information in response to legal requirements or to protect our rights and interests.',
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Data Security',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We implement appropriate security measures to protect your personal information and strive to maintain the confidentiality and integrity of the data we collect.',
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Data Retention',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We retain your personal information for as long as necessary to fulfill the purposes for which it was collected and to comply with legal obligations.',
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Your Rights',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'You have the right to access, update, and delete your personal information. You may also have the right to object to certain data processing activities. Please contact us to exercise your rights.',
            ),
            SizedBox(height: 16.0),
            Text(
              'By using our application, you consent to the collection and use of your personal information as described in this Privacy Policy.',
            ),
            SizedBox(height: 16.0),
            Text(
              'If you have any questions or concerns about our Privacy Policy, please contact us.',
            ),
            Text(
              'Thank you for your trust and support.',
            ),

            // Add more text as needed
          ],
        ),
      ),
    );
  }
}
