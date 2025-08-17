import 'package:flutter/material.dart';
import 'package:mobile_banking/Common_Widgets/beneficiary_swiper.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Mobile_Recharge_Screens/recharge_confirm_screen.dart';

import '../../../../Common_Widgets/custom_selection_field.dart';
import '../../../../Common_Widgets/custom_textfield.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  int selectedTransaction = 0; // For choosing transaction type
  bool saveToDirectory = false;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? selectedAccount;
  int _selectedBeneficiaryIndex = -1; // -1 means none selected
  bool _isFormValid = false;
  final List<String> accounts = [
    '1234567890',
    '9876543210',
    '1122334455',
  ];
  final List<Map<String, String?>> _beneficiaries = [
    { 'name': null, 'imageUrl': null}, // Add button
    { 'name': 'Hafiz', 'imageUrl': 'assets/images/profile_img.jpeg'},
    { 'name': 'Abrar', 'imageUrl': 'assets/images/profile_img.jpeg'},
    { 'name': 'Sabri', 'imageUrl': 'assets/images/profile_img.jpeg'},
  ];

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_validateForm);
    _amountController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      final amountText = _amountController.text;
      final amount = double.tryParse(amountText) ?? 0;

      _isFormValid = _phoneController.text.isNotEmpty && amount >= 100;
    });
  }


  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  void _showAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Select Account',
            style: TextStyle(color: Colors.black, fontSize: 16),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: accounts.map((acc) {
              return ListTile(
                title: Text(acc,
                  style: const TextStyle(color: Colors.black, fontSize: 14),),
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
  Widget buildLabelText(String text,
      {Color? color, double fontSize = 14, FontWeight fontWeight = FontWeight.bold}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ?? Colors.grey[500],
      ),
    );
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
          "Mobile Recharge",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Dropdown
            CustomSelectionField(
              controller: _accountController,
              hintText: "Choose account/card",
              onTapSuffix: _showAccountDialog,
            ),
            const SizedBox(height: 6),
            // Show available balance only if account is filled
            if (_accountController.text.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                "Available balance: 10,000\$",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[900]),
              ),
            ],
            const SizedBox(height: 20),
            // Choose beneficiary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose beneficiary",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[500]),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Find beneficiary",
                    style: TextStyle(color: Colors.blue[900], fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 110, // enough space for avatar + text
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _beneficiaries.length,
                itemBuilder: (context, index) {
                  final beneficiary = _beneficiaries[index];
                  return BeneficiarySwiperItem(
                    name: beneficiary['name'],
                    imageUrl: beneficiary['imageUrl'],
                    selected: _selectedBeneficiaryIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedBeneficiaryIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 50, left: 12, right: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 10),
                      buildLabelText('phone number'),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _phoneController,
                        hintText: 'phone number',
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      buildLabelText('Amount'),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _amountController,
                        hintText: 'At least 100',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20), // Checkbox
                      const SizedBox(height: 16),
                      // Confirm button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isFormValid
                              ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ConfirmRechargeScreen(
                                      senderAccount: _accountController.text,
                                      beneficiaryAccount: _phoneController.text,
                                      amount: double.tryParse(
                                          _amountController.text) ?? 0.0,
                                    ),
                              ),
                            );
                          }
                              : null, // 🚫 disabled if form invalid
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFormValid
                                ? Colors.blue[900]
                                : Colors.grey, // show grey if disabled
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: const Text(
                            "Proceed",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      );
    }
  }
