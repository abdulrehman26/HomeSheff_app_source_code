import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'checker.dart';
import 'loginscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  File? _selectedImage;

  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
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
    String email = _emailController.text.trim();
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
  //  _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
        return ProgressHUD(
            child: Builder(
                builder: (BuildContext context) {
                  return SingleChildScrollView(
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
                                labelText: 'Name',
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
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                email = value;
                              },
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
                              decoration: InputDecoration(
                                labelText: 'Email',
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
                              textInputAction: TextInputAction.next,
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
                              textInputAction: TextInputAction.next,
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
                            // onPressed: _navigateToLoginPage,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                final progress = ProgressHUD.of(context);
                                progress?.show();
                                try {
                                  final UserCredential userCredential = await _auth
                                      .createUserWithEmailAndPassword(
                                      email: email, password: password);
                                  if (userCredential.user != null) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())); // Perform actions for successful login
                                    print('Login successful!');
                                    // Your code here...
                                  }
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
                  );
                },
                  ),
                  );
          },
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




// ProgressHUD(
// child: Builder(
// builder: (context) => SingleChildScrollView(
//
// ElevatedButton(
// onPressed: () async {
// if (_formKey.currentState!.validate()) {
// // Form is valid, proceed with sign up
// setState(() {
// _isLoading = true;
// });
// final progress = ProgressHUD.of(context);
// progress?.show();
// try {
// await _auth.createUserWithEmailAndPassword(
// email: '',
// password: password,
// );
// // Sign up successful, navigate to next screen
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => LoginScreenq(phoneNumber: '', password: '',),
// ),
// );
// } catch (e) {
// // Sign up failed, display error message
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// title: Text('Error'),
// content: Text(e.toString()),
// actions: <Widget>[
// TextButton(
// child: Text('OK'),
// onPressed: () {
// Navigator.of(context).pop();
// },
// ),
// ],
// );
// },
// );
// } finally {
// setState(() {
// _isLoading = false;
// });
// progress?.dismiss();
// }
// }
// },
// child: _isLoading
// ? CircularProgressIndicator()
//     : Text('Sign Up'),
// ),