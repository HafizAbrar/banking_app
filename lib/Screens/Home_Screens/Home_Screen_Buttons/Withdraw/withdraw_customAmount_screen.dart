import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

import 'confirm_withdraw_screen.dart';
class WithdrawCustomAmountScreen extends StatefulWidget {
  final String accountNumber;
  final String phoneNumber;

  const WithdrawCustomAmountScreen({
    super.key,
    required this.accountNumber,
    required this.phoneNumber,
  });


  @override
  State<WithdrawCustomAmountScreen> createState() => _WithdrawCustomAmountScreenState();
}

class _WithdrawCustomAmountScreenState extends State<WithdrawCustomAmountScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int? selectedAmount;
  final List<int> amounts = [100, 500, 1000, 2000, 5000];
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isAuthenticated = false;

    try {
      if (canCheckBiometrics) {
        isAuthenticated = await auth.authenticate(
          localizedReason: 'Please verify your fingerprint to confirm the transaction',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    if (isAuthenticated) {
      // Proceed with transaction
      Navigator.push(
          context, MaterialPageRoute(builder: (context)=> WithdrawConfirmationScreen())
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fingerprint authentication failed')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _accountController.text = widget.accountNumber;
    _phoneController.text = widget.phoneNumber;
    _accountController.addListener(_updateState);
    _phoneController.addListener(_updateState);
    _amountController.addListener(_updateState);
    _amountController.addListener(_formatAmount);
  }
  void _formatAmount() {
    String text = _amountController.text.replaceAll(RegExp(r'[^0-9]'), ''); // remove everything except numbers
    if (text.isNotEmpty) {
      _amountController.value = TextEditingValue(
        text: '₨ $text', // Add currency symbol here
        selection: TextSelection.collapsed(offset: '₨ $text'.length), // Keep cursor at the end
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {}); // Refresh to enable/disable Verify button
  }

  bool get isFormValid =>
      _accountController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _amountController.text.isNotEmpty ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // let the screen move when keyboard appears
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Withdraw',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // <-- makes content scrollable
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image at the top
            Center(
              child: Image.asset(
                'assets/images/withdraw_img.png',
                height: 188,
                width: 342,
              ),
            ),
            const SizedBox(height: 20),

            // Account Number field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      controller: _accountController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text('Availble balance is ${selectedAmount ?? '10000'}',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              ),
            SizedBox(height: 10,),
            // Phone Number field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: 'phone number',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            //custom amount container
            Text('Enter amount',style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),

            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Verify button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFormValid ? _authenticate : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.blue[900],
                  disabledBackgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}