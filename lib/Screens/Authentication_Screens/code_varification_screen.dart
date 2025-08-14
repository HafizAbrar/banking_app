
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'change_password_screen.dart';



class CodeVarificationScreen extends StatefulWidget {
  final String phoneNumber;
  const CodeVarificationScreen({
    required this.phoneNumber,
    super.key});

  @override
  State<CodeVarificationScreen> createState() => _CodeVarificationScreenState();
}

class _CodeVarificationScreenState extends State<CodeVarificationScreen> {
  // Controllers to manage the text being entered in TextFields
  final TextEditingController _phoneNumberController = TextEditingController();
  late FocusNode _phoneNumberFocusNode;
  final _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    // Add listeners to check text changes
    _phoneNumberFocusNode = FocusNode();
    _phoneNumberController.addListener(_validateFields);
  }
  void _validateFields() {
    setState(() {
      isButtonEnabled = _phoneNumberController.text.length==4;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text('Forgot Password',
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: context.screenHeight*0.45,
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
                      Text('Type varification Code here!',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      SizedBox(height: 10,),
                      // Text field for phone number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: context.screenWidth*0.5,
                            child: TextFormField(
                              focusNode: _phoneNumberFocusNode,
                              style: TextStyle(color: Colors.black),
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                hintText: 'Code',
                                prefixIcon: Icon(Icons.phone_android_outlined,color: Colors.blue[900],), // Icon before the text input
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],// Type of keyboard to show
                              // Optional: Add validation
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter varification code';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                          SizedBox(width: context.screenWidth*0.3,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsetsGeometry>( EdgeInsets.fromLTRB(20,15,20,15)),
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
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
                              onPressed:(){
                                print("Login button pressed");
                                /* Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                );
                              */},

                              child: const Text(
                                'Resend',
                                style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 16  ), // Text color for the button
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:10,),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: 'We have sent you a code to verify your phone number '),
                            TextSpan(
                              text: widget.phoneNumber,
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,// optional
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'The code will expire after 10 minutes.If you did not receive the code please click Resend.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

                          Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                              );
                            }:null,

                        child: const Text(
                          'Change password',
                          style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 16  ), // Text color for the button
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Change phone number',
                style: TextStyle(color: Colors.blue[900],fontSize: 14,fontWeight: FontWeight.bold),
              ),
          ),
        ],
      ),

    );
  }
}