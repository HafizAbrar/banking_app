import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Beneficiary_Screens/save_beneficiary_screen.dart';
import 'dart:io';

import '../../../../Common_Widgets/custom_selection_field.dart';
import '../../../../Common_Widgets/custom_textfield.dart';
import '../../../../Common_Widgets/transaction_swiper.dart';

class AddNewBeneficiaryScreen extends StatefulWidget {
  const AddNewBeneficiaryScreen({super.key});

  @override
  State<AddNewBeneficiaryScreen> createState() => _AddNewBeneficiaryScreenState();
}

class _AddNewBeneficiaryScreenState extends State<AddNewBeneficiaryScreen> {
  int selectedTransaction = 0; // For choosing transaction type
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  File? _selectedImage;
  String? selectedAccount;
  String? imageUrl='';
  bool _isFormValid = false;
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


  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _cardNumberController.addListener(_validateForm);
    _bankController.addListener(_validateForm);
    _branchController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _bankController.text.isNotEmpty &&
          _branchController.text.isNotEmpty && _nameController.text.isNotEmpty
          && _cardNumberController.text.isNotEmpty;
    });
  }
  @override
  void dispose() {
    _bankController.dispose();
    _branchController.dispose();
    _nameController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.green),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
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
          "Add new beneficiary",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),
            // Profile Image
            // Profile Image + FAB overlay
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                      child: _selectedImage == null
                          ? const Icon(Icons.person, size: 50, color: Colors.grey)
                          : null,
                    ),
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.blue[900],
                      shape: const CircleBorder(),
                      onPressed: _showImageSourceActionSheet,
                      child: Icon(
                        _selectedImage == null ? Icons.add : Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Sabri Sahib",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
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
            // Text fields
            // 👇 Conditional rendering based on transaction type
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

                      const SizedBox(height: 40),
                      // Confirm button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isFormValid
                              ? () {
                            //save beneficiary screen will be here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaveBeneficiaryScreen(
                                  name: _nameController.text,
                                  cardNumber: _cardNumberController.text,
                                  bank: _bankController.text,
                                  branch: _branchController.text,
                                  transactionType: selectedTransaction,
                                  image: _selectedImage,
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
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            "Save to directory",
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
        ),
      ),
    );
  }
}
