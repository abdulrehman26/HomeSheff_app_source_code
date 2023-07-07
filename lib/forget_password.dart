import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/loginscreen.dart';


class ForgotPasswordScreen extends StatelessWidget {
  final formKey2 = GlobalKey<FormState>();
  final TextEditingController emailController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Forget Password?",
                style: GoogleFonts.ptSans(
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(1, 1), // Adjust the values to control the shadow position
                      blurRadius: 10, // Adjust the value to control the blurriness of the shadow
                    ),
                  ],
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),),SizedBox(height: 32),
              Form(
                key: formKey2,
                child: Container(
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
                    controller: emailController2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                    style:
                    Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (formKey2.currentState!.validate()) {
                    final String email = emailController2.text.trim();
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: email,
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage()),
                              (route) => false);
                    } catch (e) {
                    }
                  }},
                child: Text('Reset Password'),
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
      ),
    );
  }
}