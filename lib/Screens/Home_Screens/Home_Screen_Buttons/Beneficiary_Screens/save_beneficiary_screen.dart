
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';

import '../../../../Common_Widgets/custom_textfield.dart';
class SaveBeneficiaryScreen extends StatefulWidget {
  final String name;
  final String cardNumber;
  final String bank;
  final String branch;
  final int transactionType;
  final File? image;

  const SaveBeneficiaryScreen({
    super.key,
    required this.name,
    required this.cardNumber,
    required this.bank,
    required this.branch,
    required this.transactionType,
    this.image,
  });


  @override
  State<SaveBeneficiaryScreen> createState() => _SaveBeneficiaryScreenState();
}

class _SaveBeneficiaryScreenState extends State<SaveBeneficiaryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  @override
  void initState() {
    super.initState();
    _bankController.text = widget.bank;
    _branchController.text = widget.branch;
    _nameController.text = widget.name;
    _cardNumberController.text = widget.cardNumber;
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
Widget buildLabelText(String text,){
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.grey[500],
      ),
    );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false, // so Flutter doesn't add its default back button
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 20), // space between avatar and title
            child: Text(
              'Save Beneficiary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: false,
        ),
      ),
      // replace your body: Stack(...) with this ↓
      body: Stack(
      clipBehavior: Clip.none,
      children: [
        // Main white container
        Container(
          margin: EdgeInsets.only(top: 50),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔹 Fixed text
                Text(
                  'Sabri Sahib',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman',
                    color: Colors.blue[900],
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Scrollable section
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildLabelText('Bank name'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _bankController,
                                hintText: 'bank name',
                                keyboardType: TextInputType.text,
                                onChanged: (_) => _validateForm(),
                              ),
                              const SizedBox(height: 20),

                              buildLabelText('Branch name'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _branchController,
                                hintText: 'Branch',
                                keyboardType: TextInputType.text,
                                onChanged: (_) => _validateForm(),
                              ),
                              const SizedBox(height: 20),

                              buildLabelText('Beneficiary name'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _nameController,
                                hintText: 'Name',
                                keyboardType: TextInputType.text,
                                onChanged: (_) => _validateForm(),
                              ),
                              const SizedBox(height: 20),

                              buildLabelText('Card number'),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _cardNumberController,
                                hintText: 'Card Number',
                                keyboardType: TextInputType.number,
                                onChanged: (_) => _validateForm(),
                              ),
                              const SizedBox(height: 30),

                              // confirm button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _isFormValid
                                      ? () {
                                    print("Bank: ${_bankController.text}");
                                    print("Branch: ${_branchController.text}");
                                    print("Beneficiary Name: ${_nameController.text}");
                                    print("Card Number: ${_cardNumberController.text}");
                                    print("Transaction Type: ${widget.transactionType}");
                                    print("Image Path: ${widget.image?.path ?? "No Image"}");
                                  }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isFormValid
                                        ? Colors.blue[900]
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  child: const Text(
                                    "Confirm",
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
                        const SizedBox(height: 20), // extra padding for scroll
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    ),
        ),

        // Positioned CircleAvatar
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue[900],
            backgroundImage:
            widget.image != null ? FileImage(widget.image!) : null,
            child: widget.image == null
                ? const Icon(Icons.person, size: 50, color: Colors.white)
                : null,
          ),
        ),
      ],
    ),
    );
  }
}
