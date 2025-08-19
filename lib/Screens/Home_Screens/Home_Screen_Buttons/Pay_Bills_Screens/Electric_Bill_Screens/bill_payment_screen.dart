import 'package:flutter/material.dart';
import 'package:mobile_banking/Common_Widgets/custom_selection_field.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Pay_Bills_Screens/Electric_Bill_Screens/payment_confirmation_screen.dart';

import '../../../../../Common_Widgets/custom_textfield.dart';

class ElectricBillPaymentScreen extends StatefulWidget {
  final String referenceNumber;

  const ElectricBillPaymentScreen({super.key, required this.referenceNumber});

  @override
  State<ElectricBillPaymentScreen> createState() => _ElectricBillPaymentScreenState();
}

class _ElectricBillPaymentScreenState extends State<ElectricBillPaymentScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _isFormValid = false;
  bool _isGetPin = false;
  String? selectedAccount;

  final List<String> accounts = [
    '1234567890',
    '9876543210',
    '1122334455',
  ];

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_validateForm);
    _pinController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isGetPin = _accountController.text.isNotEmpty;
      _isFormValid =
          _accountController.text.isNotEmpty && _pinController.text.isNotEmpty;
    });
  }

  void _showAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Select Account',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: accounts.map((acc) {
              return ListTile(
                title: Text(
                  acc,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
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
  @override
  Widget build(BuildContext context) {
    // Example data (replace with API result)
    final billData = {
      "referenceNumber": widget.referenceNumber,
      "consumerName": "Ali Khan",
      "billingMonth": "August 2025",
      "dueDate": "25-08-2025",
      "amount": 4520,
      "status": "Unpaid"
    };

    Widget buildRow(String label, String value, {Color? valueColor}) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.grey[600])),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          " Electric Bill Payment",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildRow("Reference No", billData['referenceNumber'].toString()),
                    buildRow("Consumer Name", billData['consumerName'].toString()),
                    buildRow("Billing Month", billData['billingMonth'].toString()),
                    buildRow("Due Date", billData['dueDate'].toString()),
                    buildRow("Amount", "Rs. ${billData['amount']}"),
                    buildRow("Status", billData['status'].toString(),
                        valueColor: billData['status'] == "Paid"
                            ? Colors.green
                            : Colors.red),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Select Account Field
            CustomSelectionField(
              controller: _accountController,
              hintText: "Select Account",
              onTapSuffix: () => _showAccountDialog(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:_isGetPin? Colors.blue[900]:Colors.grey[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed:_isGetPin? () {
                        //method to get pin dynamically(real time)
                      }:null,
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
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:_isFormValid? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ElectricBillPaymentConfirmationScreen()),
                  );
                }:null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:_isFormValid? Colors.blue[900]:Colors.blue[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Confirm Payment",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
