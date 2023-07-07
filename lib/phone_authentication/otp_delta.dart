import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_delta.dart';

class OtpScreen extends StatefulWidget {
  final ConfirmationResult confirmationResult;

  OtpScreen({required this.confirmationResult, required Null Function() onVerificationComplete});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    final UserCredential userCredential =
    await widget.confirmationResult.confirm(otp);

    if (userCredential.user != null) {
      // Navigate to Login screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('OTP Error'),
            content: Text('Failed to verify OTP. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
