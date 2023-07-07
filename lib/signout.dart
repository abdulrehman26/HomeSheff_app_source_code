import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:login/loginscreen.dart';

import 'checker.dart';

class SignOutScreen extends StatefulWidget {
  @override
  State<SignOutScreen> createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: Builder(
        builder: (BuildContext context) {
      return ProgressHUD(
          child: Builder(
          builder: (BuildContext context) {
        return Center(
        child: ElevatedButton(
          child: Text('Sign Out'),
          onPressed: () {
            _signOut(context);
          },
        ),
      );
          },
          ),
      );
        },
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final progress = ProgressHUD.of(context);
    progress?.show();
    await Future.delayed(Duration(seconds: 1));
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginPage()));
      // You can navigate to the login screen or any other screen after signing out
    } catch (e) {
      // Handle sign-out error
      print(e.toString());
    }
    progress?.dismiss();
    setState(() {
      _isLoading = false;
    });
  }
}
