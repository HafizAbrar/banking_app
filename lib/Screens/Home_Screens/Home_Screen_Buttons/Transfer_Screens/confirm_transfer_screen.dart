import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Transfer_Screens/transfer_success_screen.dart';
import '../../../../Common_Widgets/custom_textfield.dart';

enum AuthMethod { none, fingerprint, faceScan, pin }
AuthMethod selectedMethod = AuthMethod.none;

class ConfirmTransferScreen extends StatefulWidget {
  final String senderAccount;
  final String beneficiaryName;
  final String beneficiaryBank;
  final String beneficiaryAccount;
  final String transferContent;
  final double amount;

  const ConfirmTransferScreen({
    super.key,
    required this.beneficiaryBank,
    required this.senderAccount,
    required this.beneficiaryName,
    required this.beneficiaryAccount,
    required this.transferContent,
    required this.amount,
  });

  @override
  State<ConfirmTransferScreen> createState() => _ConfirmTransferScreenState();
}

class _ConfirmTransferScreenState extends State<ConfirmTransferScreen> {
  final TextEditingController _senderCardNumberController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverAccountNumberController = TextEditingController();
  final TextEditingController _transferContentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transferFeeController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();
  bool isPinEntered = false;
  bool isBiometricSuccess = false;

  @override
  void initState() {
    super.initState();
    _senderCardNumberController.text = widget.senderAccount;
    _receiverNameController.text = widget.beneficiaryName;
    _receiverAccountNumberController.text = widget.beneficiaryAccount;
    _transferContentController.text = widget.transferContent;
    _amountController.text = widget.amount.toString();
    _transferFeeController.text = "\$10.0";

    _pinController.addListener(() {
      setState(() {
        isPinEntered = _pinController.text.isNotEmpty;
      });
    });
  }

  Future<void> _authenticateWithBiometrics(String reason) async {
    try {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      setState(() {
        isBiometricSuccess = didAuthenticate;
      });

      if (didAuthenticate) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed.')),
        );
      }
    } catch (e) {
      debugPrint("Biometric error: $e");
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  bool get isConfirmEnabled {
    if (selectedMethod == AuthMethod.pin) return isPinEntered;
    if (selectedMethod == AuthMethod.fingerprint || selectedMethod == AuthMethod.faceScan) {
      return isBiometricSuccess;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Confirm Transfer",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirm transaction information!',
                style: TextStyle(fontSize: 16, color: Colors.blue[900]),
              ),
              const SizedBox(height: 10),
              _sectionLabel('From'),
              CustomTextField(controller: _senderCardNumberController, hintText: 'Card number', keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _sectionLabel('To'),
              CustomTextField(controller: _receiverNameController, hintText: 'Name', keyboardType: TextInputType.text),
              const SizedBox(height: 10),
              _sectionLabel('Card number'),
              CustomTextField(controller: _receiverAccountNumberController, hintText: 'Account number', keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _sectionLabel('Transfer Fee'),
              CustomTextField(controller: _transferFeeController, hintText: 'Transfer Fee', keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _sectionLabel('Transfer Content'),
              CustomTextField(controller: _transferContentController, hintText: 'Transfer Content', keyboardType: TextInputType.text),
              const SizedBox(height: 10),
              _sectionLabel('Amount'),
              CustomTextField(controller: _amountController, hintText: 'Amount', keyboardType: TextInputType.number),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAuthCheckbox(AuthMethod.fingerprint, "Fingerprint"),
                  _buildAuthCheckbox(AuthMethod.faceScan, "Face Scan"),
                  _buildAuthCheckbox(AuthMethod.pin, "PIN"),
                ],
              ),
              const SizedBox(height: 10),

              Center(
                child: Builder(
                  builder: (context) {
                    if (selectedMethod == AuthMethod.fingerprint) {
                      return IconButton(
                        icon: Icon(Icons.fingerprint, size: 40, color: Colors.blue[900]),
                        onPressed: () => _authenticateWithBiometrics("Authenticate with fingerprint"),
                      );
                    }
                    if (selectedMethod == AuthMethod.faceScan) {
                      return IconButton(
                        icon: Icon(Icons.face, size: 40, color: Colors.blue[900]),
                        onPressed: () => _authenticateWithBiometrics("Authenticate with Face ID"),
                      );
                    }
                    if (selectedMethod == AuthMethod.pin) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[900],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Get PIN"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              controller: _pinController,
                              hintText: 'Enter PIN',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isConfirmEnabled ? Colors.blue[900] : Colors.grey[400],
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: isConfirmEnabled
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransferConfirmationScreen(
                  beneficiaryName: widget.beneficiaryName,
                  amount: widget.amount,
                ),
              ),
            );
          }
              : null,
          child: const Text(
            "Confirm Transaction",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthCheckbox(AuthMethod method, String label) {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            checkboxTheme: CheckboxThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: WidgetStateBorderSide.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return BorderSide(color: Colors.blue[900]!, width: 2);
                }
                return BorderSide(color: Colors.grey[400]!, width: 2);
              }),
              fillColor: WidgetStateProperty.all(Colors.white),
              checkColor: WidgetStateProperty.all(Colors.blue[900]),
            ),
          ),
          child: Checkbox(
            value: selectedMethod == method,
            onChanged: (val) {
              setState(() {
                selectedMethod = val! ? method : AuthMethod.none;
                isBiometricSuccess = false; // reset biometric state
              });
            },
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[500],
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
