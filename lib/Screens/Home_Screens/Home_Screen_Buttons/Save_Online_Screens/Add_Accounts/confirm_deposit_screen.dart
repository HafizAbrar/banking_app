
import 'package:flutter/material.dart';

import '../../../home_navigation_screen.dart';
class ConfirmDepositScreen extends StatelessWidget {
  const ConfirmDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,

                ),
                child: Image.asset('assets/images/addNew_savingAccount_logo.png',fit: BoxFit.contain,),
              ),
            ),
            SizedBox(height: 20,),
            Text('Withdraw Successfully!',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text('your have successfully saved your money.To check your balance press the button below',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,

                ),
                maxLines: 3,
              ),
            ),
            SizedBox(height: 20,),
            // Login Button
            ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>( EdgeInsets.fromLTRB(150,15,150,15)),
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
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeNavigationScreen()),
                );
              },


              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => CodeVarificationScreen(
              //       phoneNumber: _phoneNumberController.text,
              //     )),
              //   );


              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18  ), // Text color for the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
