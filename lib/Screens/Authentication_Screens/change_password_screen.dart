
import 'package:flutter/material.dart';
import 'package:mobile_banking/Screens/Authentication_Screens/security_success_screen.dart';
import 'package:velocity_x/velocity_x.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Controllers to manage the text being entered in TextFields
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late FocusNode _newPasswordFocusNode;
  late FocusNode _confirmPasswordFocusNode;
  final _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    // Add listeners to check text changes
    _confirmPasswordFocusNode = FocusNode();
    _confirmPasswordController.addListener(_validateFields);
    _newPasswordFocusNode = FocusNode();
    _newPasswordController.addListener(_validateFields);
  }
  void _validateFields() {
    setState(() {
      isButtonEnabled = _newPasswordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        // leading: IconButton(onPressed: (){
        //   Navigator.pop(context);
        // },
        //     icon: Icon(Icons.arrow_back_ios,color: Colors.black,)
        // ),
        title: const Text('Change Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: context.screenHeight*0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),

              ),
              child: Form(
                // Using a Form widget for better structure and potential validation
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end, // Center the column content vertically
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to fill horizontal space
                    children: <Widget>[
                      Text('New Password',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      SizedBox(height: 10,),
                      // Text field for phone number
                      TextFormField(
                        focusNode: _newPasswordFocusNode,
                        style: TextStyle(color: Colors.black),
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'New password',
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
                      SizedBox(height:10,),
                      Text('Confirm Password',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      SizedBox(height: 10,),
                      // Text field for phone number
                      TextFormField(
                        focusNode: _confirmPasswordFocusNode,
                        style: TextStyle(color: Colors.black),
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'confirm password',
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
                      SizedBox(height: 20,),
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
                        onPressed:isButtonEnabled?(){
                          if(_newPasswordController.text!=_confirmPasswordController.text){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password does not match')),
                            );
                            return;
                          }
                          else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecuritySuccessScreen()),
                            );
                          }


                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => CodeVarificationScreen(
                        //       phoneNumber: _phoneNumberController.text,
                        //     )),
                        //   );
                         }:null,

                        child: const Text(
                          'Send',
                          style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 22  ), // Text color for the button
                        ),
                      ),
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