import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:mobile_banking/Common_Widgets/custom_selection_field.dart';

import '../../../../../Common_Widgets/custom_textfield.dart';


class AddNewSavingAccountScreen extends StatefulWidget {
  const AddNewSavingAccountScreen({super.key});


  @override
  State<AddNewSavingAccountScreen> createState() => _AddNewSavingAccountScreenState();
}

class _AddNewSavingAccountScreenState extends State<AddNewSavingAccountScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int? selectedAmount;
  String? selectedDeposit;
  String? selectedAccount;
  final List<int> amounts = [100, 500, 1000, 2000, 5000];
  final LocalAuthentication auth = LocalAuthentication();
  final List<String> accounts = [
    '1234567890',
    '9876543210',
    '1122334455',
  ];
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
  void _showDepositDialog() {
    final List<String> depositTimes = [
      "3 Months",
      "6 Months",
      "12 Months",
      "24 Months",
      "36 Months"
    ];

    final List<String> interestRates = [
      "5%",
      "7%",
      "10%",
      "12%",
      "15%"
    ];

    // Combine both lists
    final List<String> depositOptions = List.generate(
      depositTimes.length,
          (index) => "${depositTimes[index]} with interest rate ${interestRates[index]}",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Deposit Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: depositOptions.map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  setState(() {
                    selectedDeposit = option;   // store selected deposit
                    _depositController.text = option; // show in TextField if you have one
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
          context, MaterialPageRoute(builder: (context)=> AddNewSavingAccountScreen())
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
    _accountController.addListener(_updateState);
    _depositController.addListener(_updateState);
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
          _depositController.text.isNotEmpty &&
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
        title:  Text(
          'Add',
          style: TextStyle(color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,),
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
                'assets/images/addNew_savingAccount_logo.png',
                height: 188,
                width: 342,
              ),
            ),
            const SizedBox(height: 20),

            // Account Number field
            Container(
              width:  double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  CustomSelectionField(
                      controller: _accountController,
                      hintText: 'choose account',
                      onTapSuffix: ()=>_showAccountDialog(),
                  ),
                  SizedBox(height: 20,),
                  CustomSelectionField(
                    controller: _depositController,
                    hintText: 'select deposit time',
                    onTapSuffix: ()=>_showDepositDialog(),
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    controller: _amountController,
                    hintText: 'amount',
                    keyboardType: TextInputType.number,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  SizedBox(height: 40,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isFormValid ?(){ _authenticate;
                      }: null,
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
          ],
        ),
      ),
    );
  }
}