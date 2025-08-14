

import 'package:flutter/material.dart';
import 'package:mobile_banking/Screens/Authentication_Screens/signup_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:local_auth/local_auth.dart';

import '../Home_Screens/home_navigation_screen.dart';
import 'forgot_password_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controllers to manage the text being entered in TextFields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;
  final LocalAuthentication auth = LocalAuthentication();
  // A GlobalKey for the Form widget to help with validation (optional for this simple example)
  final _formKey = GlobalKey<FormState>();
    bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    // Add listeners to check text changes
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }
  void _validateFields() {
    setState(() {
      isButtonEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }
  void _login() {
    // Basic validation: check if fields are not empty
    // You can also use _formKey.currentState.validate() if you add validators to TextFormFields
    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      // In a real app, you would send this data to your backend for authentication
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');

      // Navigate to another screen or show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful (Username: ${_usernameController.text})')),
      );

      // Example: Navigate to a HomeScreen after successful login
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()), // Assuming you have a HomeScreen
      // );

    } else {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
    }
  }
  Future<void> _authenticateWithFingerprint() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    print('Can check biometrics: $canCheckBiometrics');
    print('Device supported: $isDeviceSupported');
    print('Available biometrics: $availableBiometrics');

    if (!isDeviceSupported || !canCheckBiometrics || availableBiometrics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Biometric authentication not available')),
      );
      return;
    }

    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to sign in',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print('Authentication error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      return;
    }

    if (authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fingerprint Authentication Successful')),
        );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeNavigationScreen()),
      );
      // Navigate to home screen, etc.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed')),
      );
    }
  }


  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text('Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: context.screenHeight*0.88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),

              ),
              child: SingleChildScrollView(
                child: Form(
                  // Using a Form widget for better structure and potential validation
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,10,20,10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end, // Center the column content vertically
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to fill horizontal space
                      children: <Widget>[
                      Text('Welcome Back',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(height: 5,),
                        Text('Hello there! Sign in to continue',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,

                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 120,
                          width: 160,
                          decoration: BoxDecoration(


                          ),
                          child: Image.asset('assets/images/sign_in_logo.png',fit: BoxFit.contain,),
                        ),
                        SizedBox(height: 30,),
                        // App Logo (Optional)
                        /* const Icon(
                            Icons.lock_open, // Example icon
                            size: 80,
                            color: Colors.blueAccent,
                          ),*/

                        const SizedBox(height: 5), // Spacing

                        // Username TextField
                        TextFormField(
                          focusNode: _usernameFocusNode,
                          style: TextStyle(color: Colors.black),
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter your username',
                            prefixIcon: Icon(Icons.person,color: Colors.blue[900],), // Icon before the text input
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text, // Type of keyboard to show
                          // Optional: Add validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20), // Spacing

                        // Password TextField
                        TextFormField(
                          focusNode: _passwordFocusNode,
                          style: TextStyle(color: Colors.black),
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: Icon(Icons.lock,color: Colors.blue[900],),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            // If you want a show/hide password icon, you'd need more state management
                          ),
                          obscureText: true, // Hides the password text
                          keyboardType: TextInputType.visiblePassword,
                          // Optional: Add validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        //const SizedBox(height: 10), // Spacing
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle "Forgot Password" action
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPassword()),
                              );
                            },
                            child: Text('Forgot Password?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue[900],
                              ),),
                          ),
                        ),
                        const SizedBox(height: 10), // Spacing

                        // Login Button
                      ElevatedButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all<EdgeInsetsGeometry>( EdgeInsets.fromLTRB(50,15,50,15)),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              elevation: null,
                              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return Colors.grey[300]!; // color when disabled
                                  }
                                  return Colors.blue[900]!;   // color when enabled
                                },
                              ),
                            ),
                            onPressed: isButtonEnabled?(){

                             Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeNavigationScreen()),
                              );
                            }:null,

                            child: const Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 22  ), // Text color for the button
                            ),
                          ),
                        const SizedBox(height: 20), // Spacing
                        Center(
                          child: IconButton(
                            icon: Icon(Icons.fingerprint_outlined, size: 40, color: Colors.blue[900]),
                            onPressed: _authenticateWithFingerprint,
                            tooltip: 'Login with Fingerprint',
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Do you have an account? ',style: TextStyle(color: Colors.grey),),
                            SizedBox(width: 5,),
                            TextButton(
                              onPressed: () {
                                // Handle "Forgot Password" action
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                                );
                              },
                              child:  Text('Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[900],
                                ),),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),

    );
  }
}