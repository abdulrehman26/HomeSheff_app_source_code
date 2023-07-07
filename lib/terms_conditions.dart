import 'package:flutter/material.dart';

class TermsAndPoliciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9161AB),
        title: Text('Terms and Policies'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to our mobile application. By downloading, installing, or using this application, you accept and agree to be bound by the following terms and conditions. Please read them carefully.',
            ),
            SizedBox(height: 16.0),
            Text(
              '1. User License',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We grant you a limited, non-exclusive, non-transferable, revocable license to use the application for personal, non-commercial purposes. You may not modify, distribute, or reverse engineer the application without our prior written consent.',
            ),
            SizedBox(height: 16.0),
            Text(
              '2. User Responsibilities',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'You are solely responsible for your use of the application. You agree to comply with all applicable laws and regulations and not to engage in any illegal or unauthorized activities while using the application. You are responsible for maintaining the confidentiality of your account and password.',
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Current Policies',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We respect your privacy and handle your personal information in accordance with our Privacy Policy. By using this application, you consent to the collection, storage, and use of your personal information as outlined in our Privacy Policy.',
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Intellectual Property',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'All intellectual property rights in the application, including but not limited to copyrights, trademarks, and logos, are owned by us or our licensors. You may not use, reproduce, or distribute any content from the application without our prior written consent.',
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Disclaimer of Warranties',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'The application is provided on an "as is" and "as available" basis. We make no representations or warranties of any kind, express or implied, regarding the application\'s operation or the content, materials, or services included in the application.',
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Limitation of Liability',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'In no event shall we be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use of the application or the inability to use it.',
            ),
            SizedBox(height: 16.0),
            Text(
              'By using this application, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.',
            ),
            SizedBox(height: 16.0),
            Text(
              'If you have any questions or concerns, please contact us.',
            ),
            Text(
              'Thank you for your cooperation.',
            ),

            // Add more text as needed
          ],
        ),
      ),
    );
  }
}
