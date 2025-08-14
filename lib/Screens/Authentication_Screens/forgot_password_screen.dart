
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'code_varification_screen.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
      isButtonEnabled = _phoneNumberController.text.length==11;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,)
        ),
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
                      Text('Type your phone number',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontFamily: 'Times New Roman',
                        ),
                        ),
                      SizedBox(height: 10,),
                      // Text field for phone number
                      TextFormField(
                        focusNode: _phoneNumberFocusNode,
                        style: TextStyle(color: Colors.black),
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'phone',
                          hintText: 'Contact Number',
                          prefixIcon: Icon(Icons.phone_android_outlined,color: Colors.blue[900],), // Icon before the text input
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],// Type of keyboard to show
                        // Optional: Add validation
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height:10,),
                      Text(
                        'We will send you a code to verify your phone number',
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

                           Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CodeVarificationScreen(
                                  phoneNumber: _phoneNumberController.text,
                                )),
                              );
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