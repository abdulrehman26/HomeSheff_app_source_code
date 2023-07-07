import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:login/phony.dart';
import 'checker.dart';
import 'login_chef.dart';
import 'loginscreen.dart';
import 'otpverification.dart';

class SignUpPhone extends StatefulWidget {
  @override
  _SignUpPhoneState createState() => _SignUpPhoneState();
}

class _SignUpPhoneState extends State<SignUpPhone> {
  final _auth = FirebaseAuth.instance;
  late String phone;
  late String password;
  File? _selectedImage;
  String _verificationId = '';
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Future<void> _signUpWithPhoneNumberAndPassword() async {
    final phoneNumber = _phoneNumberController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '$phoneNumber@example.com',
        password: password,
      );

      if (userCredential.user != null) {
        // Successfully signed up, navigate to OTP screen
        print('success');
      }
    } on FirebaseAuthException catch (e) {

    }
  }
  Future<void> _verifyPhoneNumber() async {
    final phoneNumber = _phoneNumberController.text.trim();
    final password = _passwordController.text.trim();
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      // Sign up the user with email and password
      try {
        final UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: '$phoneNumber@example.com',
          password: password,
        );
        // Perform actions for successful signup
        print('Signup successful!');
        // Your code here...
      } catch (e) {
        // Handle signup failure
      }
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      // Handle verification failure
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) {
      _verificationId = verificationId;
      // Navigate to the OTP verification screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            verificationId: verificationId,
            resendToken: resendToken,
            phoneNumber: _phoneNumberController.text,
            password: _passwordController.text,
          ),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }


//   Future<void> _verifyPhoneNumber() async {
//       final PhoneVerificationCompleted verificationCompleted =
//           (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//         {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreenq(phoneNumber: '', password2: '',))); // Perform actions for successful login
//           print('Login successful!');
//           // Your code here...
//         }
//       };
//     final PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException e) {
//       // Handle verification failure
//     };
//     final PhoneCodeSent codeSent =
//         (String verificationId, int? resendToken) {
//       _verificationId = verificationId;
//       // Navigate to the OTP verification screen
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               OtpVerificationScreen(
//                 verificationId: verificationId,
//                 resendToken: resendToken,
//                 phoneNumber: _phoneNumberController.text,
//                 password: _passwordController.text,
//               ),
//         ),
//       );
//
//     };
//
//     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       _verificationId = verificationId;
//     };
//
//     await _auth.verifyPhoneNumber(
//       phoneNumber: _phoneNumberController.text,
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     );
//
// }
  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Picture'),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }
  void _check() {
    String firstName = _firstNameController.text.trim();
    String email = _phoneNumberController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Validations
    if (_selectedImage == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Image Not Found'),
            content: Text('Please add an image to continue.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Mismatch'),
            content: Text('The passwords entered do not match.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
  }

  bool isEnglishAlphabet(String value) {
    final pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: SafeArea(
        child: ProgressHUD(
              child: Builder(
                builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _showImagePickerModal,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                                image: _selectedImage != null
                                    ? DecorationImage(
                                  image: FileImage(_selectedImage!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[600],
                                size: 40.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 150,
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
                                    controller: _firstNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z]')),
                                    ],

                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
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
                                    controller: _lastNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z]')),
                                    ],

                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
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
                              onChanged: (value) {
                                phone = value;
                              },
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
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
                              onChanged: (value) {
                                password = value;
                              },
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
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
                                labelText: 'Password',
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: Icon(
                                    _isPasswordVisible ? Icons.visibility : Icons
                                        .visibility_off,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
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
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                  onTap: _toggleConfirmPasswordVisibility,
                                  child: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons
                                        .visibility_off,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please confirm the password";
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 16.0),
                               ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    final progress = ProgressHUD.of(context);
                                    progress?.show();
                                    try {

                                     await _verifyPhoneNumber();
                                     await _signUpWithPhoneNumberAndPassword();
                                    }
                                    catch (e) {
                                      print(e);
                                    }
                                    progress?.dismiss();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: Text('Sign Up'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF11253d),
                                  minimumSize: Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an Account?'),
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
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text('Login Here!',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
            ),
      ),
    );
  }
  bool containsAlphabet(String value) {
    // Regular expression to check for at least one alphabet character
    return RegExp(r'[a-zA-Z]').hasMatch(value);
  }
}

class ProfilePage2 extends StatelessWidget {
  final File selectedImage;
  final String firstName;
  final String lastName;

  ProfilePage2({
    required this.selectedImage,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(selectedImage),
              ),
              SizedBox(height: 16.0),
              Text(
                'First Name: $firstName',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8.0),
              Text(
                'Last Name: $lastName',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




