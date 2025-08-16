import 'package:flutter/material.dart';
import 'package:mobile_banking/Common_Widgets/beneficiary_swiper.dart';

import '../../../../Common_Widgets/custom_selection_field.dart';
import '../../../../Common_Widgets/custom_textfield.dart';
import '../../../../Common_Widgets/transaction_swiper.dart';
import 'confirm_transfer_screen.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int selectedTransaction = 0; // For choosing transaction type
  bool saveToDirectory = false;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  String? selectedAccount;
  int _selectedBeneficiaryIndex = -1; // -1 means none selected
  bool _isFormValid = false;
  final List<String> accounts = [
    '1234567890',
    '9876543210',
    '1122334455',
  ];
  final List<String> pakistaniBanks = [
    "Allied Bank Limited (ABL)",
    "Askari Bank",
    "Bank Alfalah",
    "Bank Al Habib",
    "BankIslami Pakistan",
    "Dubai Islamic Bank",
    "Faysal Bank",
    "First Women Bank",
    "Habib Bank Limited (HBL)",
    "JS Bank",
    "MCB Bank",
    "Meezan Bank",
    "National Bank of Pakistan (NBP)",
    "Samba Bank",
    "Silkbank",
    "Sindh Bank",
    "Soneri Bank",
    "Standard Chartered Pakistan",
    "United Bank Limited (UBL)",
  ];

  /// Example map associating banks in Pakistan to their branch lists.
  /// Currently branches are placeholders—you can replace them with real branch names later.
  final Map<String, List<String>> bankBranches = {
    "National Bank of Pakistan (NBP)": [
      "NBP Main Branch Karachi",
      "NBP Clifton Branch Karachi",
      "NBP Saddar Branch Rawalpindi",
      "NBP Liberty Market Lahore",
      "NBP Blue Area Islamabad",
    ],
    "Habib Bank Limited (HBL)": [
      "HBL Main Branch Karachi",
      "HBL Clifton Branch Karachi",
      "HBL Liberty Market Lahore",
      "HBL Saddar Branch Rawalpindi",
      "HBL Blue Area Islamabad",
    ],
    "United Bank Limited (UBL)": [
      "UBL Head Office Karachi",
      "UBL Gulberg Lahore",
      "UBL Committee Chowk Rawalpindi",
      "UBL F-7 Islamabad",
      "UBL Tariq Road Karachi",
    ],
    "MCB Bank Limited (MCB)": [
      "MCB Main Branch Lahore",
      "MCB Saddar Karachi",
      "MCB Blue Area Islamabad",
      "MCB DHA Phase 5 Lahore",
      "MCB Gulshan Branch Karachi",
    ],
    "Allied Bank Limited (ABL)": [
      "ABL Head Office Lahore",
      "ABL Clifton Branch Karachi",
      "ABL Peshawar Saddar",
      "ABL F-10 Islamabad",
      "ABL Faisalabad Main",
    ],
    "Askari Bank Limited": [
      "Askari Bank Main Branch Rawalpindi",
      "Askari Bank Islamabad Blue Area",
      "Askari Bank Gulberg Lahore",
      "Askari Bank Clifton Karachi",
    ],
    "Bank Alfalah": [
      "Bank Alfalah Main Branch Karachi",
      "Bank Alfalah Gulberg Lahore",
      "Bank Alfalah Saddar Rawalpindi",
      "Bank Alfalah F-6 Islamabad",
    ],
    "Bank Al Habib": [
      "Bank Al Habib Main Branch Karachi",
      "Bank Al Habib Gulshan Branch Karachi",
      "Bank Al Habib Liberty Market Lahore",
      "Bank Al Habib Blue Area Islamabad",
    ],
    "Meezan Bank": [
      "Meezan Bank Tariq Road Karachi",
      "Meezan Bank I-8 Islamabad",
      "Meezan Bank DHA Lahore",
      "Meezan Bank Saddar Peshawar",
    ],
    "Faysal Bank": [
      "Faysal Bank Main Branch Karachi",
      "Faysal Bank Gulberg Lahore",
      "Faysal Bank Blue Area Islamabad",
      "Faysal Bank Saddar Rawalpindi",
    ],
    "Sindh Bank": [
      "Sindh Bank Main Branch Karachi",
      "Sindh Bank Clifton Karachi",
      "Sindh Bank Hyderabad",
      "Sindh Bank Larkana",
    ],
    "Dubai Islamic Bank": [
      "DIB Main Branch Karachi",
      "DIB Gulberg Lahore",
      "DIB Blue Area Islamabad",
      "DIB Saddar Rawalpindi",
    ],
    "Standard Chartered Bank Pakistan": [
      "SCB Clifton Karachi",
      "SCB Gulberg Lahore",
      "SCB Blue Area Islamabad",
      "SCB Saddar Rawalpindi",
    ],
    "BankIslami Pakistan": [
      "BankIslami Main Branch Karachi",
      "BankIslami DHA Lahore",
      "BankIslami I-10 Islamabad",
    ],
    "Habib Metropolitan Bank": [
      "Habib Metro Clifton Karachi",
      "Habib Metro Gulberg Lahore",
      "Habib Metro Blue Area Islamabad",
    ],
    "JS Bank": [
      "JS Bank Main Branch Karachi",
      "JS Bank Gulberg Lahore",
      "JS Bank F-7 Islamabad",
    ],
    "Samba Bank": [
      "Samba Bank Karachi",
      "Samba Bank Lahore",
      "Samba Bank Islamabad",
    ],
    "Zarai Taraqiati Bank Ltd (ZTBL)": [
      "ZTBL Islamabad Head Office",
      "ZTBL Lahore Branch",
      "ZTBL Multan Branch",
    ],
    "The Bank of Punjab (BOP)": [
      "BOP Main Branch Lahore",
      "BOP Blue Area Islamabad",
      "BOP Gulberg Lahore",
      "BOP Karachi Branch",
    ],
    "Bank of Khyber": [
      "BoK Peshawar Saddar",
      "BoK Blue Area Islamabad",
      "BoK Gulberg Lahore",
    ],
    "First Women Bank": [
      "First Women Bank Karachi",
      "First Women Bank Islamabad",
      "First Women Bank Lahore",
    ],
    "Al-Baraka Bank (Pakistan)": [
      "Al-Baraka Karachi",
      "Al-Baraka Lahore",
      "Al-Baraka Islamabad",
    ],
  };

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
    _nameController.addListener(_validateForm);
    _cardNumberController.addListener(_validateForm);
    _contentController.addListener(_validateForm);
    _amountController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      selectedTransaction == 2 ?
      _isFormValid = _accountController.text.isNotEmpty &&
          _contentController.text.isNotEmpty &&
          _amountController.text.isNotEmpty &&
          _bankController.text.isNotEmpty &&
          _branchController.text.isNotEmpty && _nameController.text.isNotEmpty
          && _cardNumberController.text.isNotEmpty
          : _isFormValid = _accountController.text.isNotEmpty &&
          _contentController.text.isNotEmpty &&
          _amountController.text.isNotEmpty
          && _nameController.text.isNotEmpty
          && _cardNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _accountController.dispose();
    _nameController.dispose();
    _cardNumberController.dispose();
    _contentController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Methods to show dialog
  void _showBankDialog(BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Select Bank",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400, // scrollable height
            child: ListView.builder(
              itemCount: pakistaniBanks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pakistaniBanks[index]),
                  onTap: () {
                    controller.text = pakistaniBanks[index]; // set bank name
                    Navigator.pop(context); // close dialog
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showBranchDialog(BuildContext context,
      String selectedBank,
      TextEditingController controller,) {
    final branches = bankBranches[selectedBank] ?? [];

    if (branches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No branches found for $selectedBank")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select Branch - $selectedBank",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: branches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(branches[index]),
                  onTap: () {
                    controller.text = branches[index]; // set selected branch
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
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
          "Transfer",
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

            // Choose transaction
            Text(
              "Choose transaction",
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[500]),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 110, // height of swiper area
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TransactionSwiperItem
                    (
                    icon: Icons.credit_card,
                    label: "Transfer via card number",
                    selected: selectedTransaction == 0,
                    onTap: () {
                      setState(() {
                        selectedTransaction = 0;
                      });
                    },
                  ),
                  TransactionSwiperItem(
                    icon: Icons.person,
                    label: "Transfer to same bank",
                    selected: selectedTransaction == 1,
                    onTap: () {
                      setState(() {
                        selectedTransaction = 1;
                      });
                    },
                  ),
                  TransactionSwiperItem(
                    icon: Icons.account_balance_outlined,
                    label: "Transfer to other bank",
                    selected: selectedTransaction == 2,
                    onTap: () {
                      setState(() {
                        selectedTransaction = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
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

            // Text fields
            // 👇 Conditional rendering based on transaction type
            if (selectedTransaction == 2) ...[
              // Transfer to Other Bank UI
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
                      buildLabelText('Select bank'),
                      const SizedBox(height: 10),
                      CustomSelectionField(
                        controller: _bankController,
                        hintText: 'Select bank',
                        onTapSuffix: () =>
                            _showBankDialog(context, _bankController),
                      ),
                      const SizedBox(height: 10),
                      buildLabelText('Select branch'),
                      const SizedBox(height: 10),
                      CustomSelectionField(
                        controller: _branchController,
                        hintText: 'Select branch',
                        onTapSuffix: () =>
                            _showBranchDialog(
                              context,
                              _bankController.text, // pass selected bank
                              _branchController,
                            ),
                      ),
                      const SizedBox(height: 10),
                      buildLabelText('beneficiary Name'),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Name',
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      buildLabelText('Card number'),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _cardNumberController,
                        hintText: 'Card number',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      buildLabelText('Amount'),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _amountController,
                        hintText: 'Amount',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      buildLabelText('content'),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _contentController,
                        hintText: 'Transfer reason/content',
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20), // Checkbox
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),),
                                side: BorderSide(color: saveToDirectory
                                    ? Colors.blue[900]!
                                    : Colors.grey[400]!, width: 2),
                                fillColor: WidgetStateProperty.all(
                                    Colors.white),
                                checkColor: WidgetStateProperty.all(
                                    Colors.blue[900]),),),
                            child: Checkbox(
                              value: saveToDirectory,
                              onChanged: (value) {
                                setState(() {
                                  saveToDirectory = value ?? false;
                                });
                              },),),
                          const SizedBox(width: 6),
                          Text("Save to directory of beneficiary",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[500]),),
                        ],),
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
                                    ConfirmTransferScreen(
                                      beneficiaryBank: _bankController.text,
                                      senderAccount: _accountController.text,
                                      beneficiaryName: _nameController.text,
                                      beneficiaryAccount: _cardNumberController
                                          .text,
                                      transferContent: _contentController.text,
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
            ] else
              ...[
                // Default transfer UI (already present in your code)
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
                        buildLabelText('Select bank'),
                        const SizedBox(height: 10),
                        CustomSelectionField(
                          controller: _bankController,
                          hintText: 'Select bank',
                          onTapSuffix: () =>
                              _showBankDialog(context, _bankController),
                        ),
                        const SizedBox(height: 10),
                        buildLabelText('beneficiary name'),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        buildLabelText('Card number'),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _cardNumberController,
                          hintText: 'Card number',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        buildLabelText('Amount'),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _amountController,
                          hintText: 'Amount',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        buildLabelText('content'),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _contentController,
                          hintText: 'Transfer reason/content',
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 20), // Checkbox
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),),
                                  side: BorderSide(color: saveToDirectory
                                      ? Colors.blue[900]!
                                      : Colors.grey[400]!, width: 2),
                                  fillColor: WidgetStateProperty.all(
                                      Colors.white),
                                  checkColor: WidgetStateProperty.all(
                                      Colors.blue[900]),),),
                              child: Checkbox(
                                value: saveToDirectory,
                                onChanged: (value) {
                                  setState(() {
                                    saveToDirectory = value ?? false;
                                  });
                                },),),
                            const SizedBox(width: 6),
                            Text("Save to directory of beneficiary",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[500]),),
                          ],),
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
                                      ConfirmTransferScreen(
                                        beneficiaryBank: _bankController.text,
                                        senderAccount: _accountController.text,
                                        beneficiaryName: _nameController.text,
                                        beneficiaryAccount: _cardNumberController
                                            .text,
                                        transferContent: _contentController
                                            .text,
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
              ],
          ],
        ),
      ),
    );
  }
}
