import 'package:flutter/material.dart';
import '../../home_navigation_screen.dart';

class TransferConfirmationScreen extends StatelessWidget {
  final String beneficiaryName;
  final double amount;

  const TransferConfirmationScreen({
    super.key,
    required this.beneficiaryName,
    required this.amount,
  });

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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Image.asset(
                  'assets/images/withdraw_img.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Transfer Successfully!',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(text: 'You have successfully transferred '),
                    TextSpan(
                      text: 'PKR ${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: ' to '),
                    TextSpan(
                      text: beneficiaryName,
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              )
            ),
            const SizedBox(height: 20),
            // OK Button
            ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.fromLTRB(150, 15, 150, 15),
                ),
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
                    return Colors.blue[900]!; // color when enabled
                  },
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeNavigationScreen(),
                  ),
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
