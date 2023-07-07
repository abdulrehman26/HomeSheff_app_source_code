import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/homescreen.dart';
import 'package:rive/rive.dart';

import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    _emailFocusNode.addListener(emailFocus);
    _passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(emailFocus);
    _passwordFocusNode.removeListener(passwordFocus);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(_emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(_passwordFocusNode.hasFocus && !_isPasswordVisible);
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
      if (!_passwordFocusNode.hasFocus) {
        isHandsUp?.change(!_isPasswordVisible);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      resizeToAvoidBottomInset: true,
      body: Builder(
        builder: (BuildContext context) {
          return ProgressHUD(
            child: Builder(
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 32),
                        Text(
                          "LOGIN",
                          style: GoogleFonts.ptSans(
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1), // Adjust the values to control the shadow position
                                blurRadius: 5, // Adjust the value to control the blurriness of the shadow
                              ),
                            ],
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),),
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: RiveAnimation.asset(
                            "assets/login-teddy.riv",
                            fit: BoxFit.fitHeight,
                            stateMachines: const ["Login Machine"],
                            onInit: (artboard) {
                              controller = StateMachineController.fromArtboard(
                                artboard,
                                "Login Machine",
                              );
                              if (controller == null) return;

                              artboard.addController(controller!);
                              isChecking = controller?.findInput("isChecking");
                              numLook = controller?.findInput("numLook");
                              isHandsUp = controller?.findInput("isHandsUp");
                              trigSuccess =
                                  controller?.findInput("trigSuccess");
                              trigFail = controller?.findInput("trigFail");
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    focusNode: _emailFocusNode,
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
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
                                    onChanged: (value) {
                                      numLook?.change(value.length.toDouble());
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: TextFormField(

                                    focusNode: _passwordFocusNode,
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters.';
                                      }
                                      if (!containsAlphabet(value)) {
                                        return 'Password must contain at least one alphabet.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          color: Color(0xFF11253d),
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          isHandsUp?.change(
                                              _passwordFocusNode.hasFocus &&
                                                  _isPasswordVisible);
                                          setState(() {
                                            _isPasswordVisible =
                                            !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: !_isPasswordVisible,
                                    style:
                                    Theme.of(context).textTheme.bodyMedium,
                                    onChanged: (value) {},
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                          overlayColor: MaterialStateProperty.resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                              if (states.contains(MaterialState.pressed)) {
                                                return Colors.transparent; // Set the color when pressed
                                              }
                                              return Colors.transparent; // Use the default color
                                            },)),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                                      },
                                      child: Text('Forget Password?',
                                        style: GoogleFonts.ptSans(
                                          shadows: [
                                            Shadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1), // Adjust the values to control the shadow position
                                              blurRadius: 10, // Adjust the value to control the blurriness of the shadow
                                            ),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  _errorMessage,
                                  style: GoogleFonts.ptSans(
                                    shadows: [
                                      Shadow(
                                        color: Colors.grey,
                                        offset: Offset(1, 1), // Adjust the values to control the shadow position
                                        blurRadius: 10, // Adjust the value to control the blurriness of the shadow
                                      ),
                                    ],
                                    color: Colors.red,
                                  ),

                                ),
                                // SizedBox(height: 10),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 64,
                                  child: ElevatedButton(
                                    onPressed: () async {

                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                          _errorMessage = '';
                                        });
                                        final progress = ProgressHUD.of(context);
                                        progress?.show();
                                        _emailFocusNode.unfocus();
                                        _passwordFocusNode.unfocus();
                                        email = _emailController.text;
                                        password = _passwordController.text;
                                        final getemail = _emailController.text;
                                        try {

                                          final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                                              email: email, password: password);
                                          if (userCredential.user != null) {
                                            trigSuccess?.change(true);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(
                                                          getemail: getemail,
                                                        )),
                                                    (route) => false);

                                            // Perform actions for successful login
                                            print('Login successful!');
                                            // Your code here...
                                          }
                                        } catch (e) {
                                          setState(() {
                                            _errorMessage =
                                            'Invalid credentials. Please try again.';
                                          });
                                          print('Error: $e');
                                        }
                                        trigFail?.change(true);
                                        progress?.dismiss();
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      };},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF11253d),
                                      minimumSize: Size(200, 200),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Text("Login"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  bool containsAlphabet(String value) {
    // Regular expression to check for at least one alphabet character
    return RegExp(r'[a-zA-Z]').hasMatch(value);
  }
}
