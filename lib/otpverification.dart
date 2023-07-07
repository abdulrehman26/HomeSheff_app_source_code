import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/login_chef.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final int? resendToken;
  final String phoneNumber;
  final String password;

  OtpVerificationScreen({
    required this.verificationId,
    required this.resendToken,
    required this.phoneNumber,
    required this.password,
  });

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _otpController = TextEditingController();

  Future<void> _signInWithPhoneNumber(String otp) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        // Perform actions for successful verification and sign in
        // For example, save the user's phone number and password
        String phoneNumber = widget.phoneNumber;
        String password = widget.password;
        // Navigate to the LoginScreen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreenq(
                      phoneNumber: phoneNumber,
                            password2: password,
                    )),
                (route) => false);
      }
    } catch (e) {
      // Handle verification failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      appBar: AppBar(
        backgroundColor: Color(0xff9161AB),
        centerTitle: true,
        title: Text('Otp Verification',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Offset in the x, y direction
                  ),
                ],
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: TextFormField(
                controller: _otpController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "OTP",
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signInWithPhoneNumber(_otpController.text),
              child: Text('Verify OTP'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF11253d),
                minimumSize: Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}