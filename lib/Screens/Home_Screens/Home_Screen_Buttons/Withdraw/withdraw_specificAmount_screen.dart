
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Withdraw/withdraw_customAmount_screen.dart';

import 'confirm_withdraw_screen.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? selectedAccount;
  final List<String> accounts = [
    '1234567890',
    '9876543210',
    '1122334455',
  ];
// Inside _WithdrawScreenState
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


  int? selectedAmount;
  final List<int> amounts = [100, 500, 1000, 2000, 5000];

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_updateState);
    _phoneController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {}); // Refresh to enable/disable Verify button
  }

  bool get isFormValid =>
      _accountController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          selectedAmount != null;

  void _showAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: accounts.map((acc) {
              return ListTile(
                title: Text(acc),
                onTap: () {
                  setState(() {
                    selectedAccount = acc;
                    _accountController.text = acc;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showCustomAmountDialog() {
    TextEditingController customController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Custom Amount'),
          content: TextField(
            controller: customController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedAmount = int.tryParse(customController.text);
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _amountButton(String label, {int? value, bool isOther = false}) {
    final bool isSelected = selectedAmount == value && !isOther;
    return GestureDetector(
      onTap: () {
        if (isOther && _accountController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) =>  WithdrawCustomAmountScreen(
                accountNumber:_accountController.text,
                phoneNumber: _phoneController.text,
              )));
        } else {
          setState(() {
            selectedAmount = value;
          });
        }
      },
      child: Container(
        height: 50,
        width: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[900] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

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
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          onPressed: _showAccountDialog,
                        ),
                        hintText: 'choose account/card',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 20),

            // Amount buttons
            Wrap(
              spacing: 20,
              runSpacing: 8,
              children: [
                for (var amt in amounts) _amountButton('Rs $amt', value: amt),
                _amountButton('Other', isOther: true),
              ],
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