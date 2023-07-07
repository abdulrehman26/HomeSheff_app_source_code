import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:login/privacy_policies.dart';
import 'package:login/terms_conditions.dart';

import 'loginscreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkModeEnabled = false;
  bool isDarkMode = false;
  void toggleDarkMode(bool newValue) {
    setState(() {
      isDarkModeEnabled = newValue;
      _updateStatusBarColor(); // Update the status bar color based on the mode
    });
  }
  void _updateStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkModeEnabled ? Colors.transparent.withOpacity(0.5) : Color(0xff9161AB),
      statusBarIconBrightness:
      isDarkModeEnabled ? Brightness.dark : Brightness.dark,
    ));
  }
  // void toggleDarkMode(bool value) {
  //   setState(() {
  //     isDarkModeEnabled = value;
  //   });
  // }
  void navigateToDarkModeScreen(BuildContext context) {
    // Handle navigation to the Dark Mode screen
    // You can replace this with your own navigation logic
    print('Navigating to Dark Mode screen...');
  }

  void navigateToPrivacyPoliciesScreen(BuildContext context) {
    // Handle navigation to the Privacy Policies screen
    // You can replace this with your own navigation logic
    print('Navigating to Privacy Policies screen...');
  }

  void navigateToTermsConditionsScreen(BuildContext context) {
    // Handle navigation to the Terms and Conditions screen
    // You can replace this with your own navigation logic

    print('Navigating to Terms and Conditions screen...');
  }

  bool _isLoading = false;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Color(0xffD6E2EA),
      body: Builder(
        builder: (context) {
          return ProgressHUD(
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      color: Color(0xffD6E2EA),
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage: AssetImage('assets/rio3.jpg',

                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () => toggleDarkMode(!isDarkModeEnabled),
                      child: ListTile(
                        leading: Icon(Icons.brightness_4),
                        title: Text('Dark/Light Status Bar'),
                        trailing: Switch(
                          value: isDarkModeEnabled,
                          onChanged: toggleDarkMode,
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyAndPoliciesScreen()));
                },
                      child: ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Privacy Policies'),
                      ),
                    ),Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsAndPoliciesScreen()));
                      },
                      child: ListTile(
                        leading: Icon(Icons.gavel),
                        title: Text('Terms and Conditions'),
                      ),
                    ),Divider(),
                    InkWell(
                      onTap: () => _signOut(context),
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Sign Out'),
                      ),
                    ),Divider(),
                  ],
                );
              }
            ),
          );
        }
      ),
    );
  }
}
