import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _validFromController = TextEditingController();
  final TextEditingController _validToController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      print("Owner Name: ${_ownerNameController.text}");
      print("Card Name: ${_cardNameController.text}");
      print("Card Number: ${_cardNumberController.text}");
      print("Valid From: ${_validFromController.text}");
      print("Valid To: ${_validToController.text}");
      print("Balance: ${_balanceController.text}");
      print("Branch: ${_branchController.text}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card Saved Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text("Add Card",style: TextStyle(color: Colors.black,),),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Owner Name", _ownerNameController),
              _buildTextField("Card Name", _cardNameController),
              _buildTextField("Card Number", _cardNumberController,
                  keyboardType: TextInputType.number),
              _buildDateField("Valid From", _validFromController),
              _buildDateField("Valid To", _validToController),
              _buildTextField("Balance", _balanceController,
                  keyboardType: TextInputType.number),
              _buildTextField("Branch", _branchController),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: _saveCard,
                child: const Text("Save",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () => _selectDate(controller),
        validator: (value) => value!.isEmpty ? "Select $label" : null,
      ),
    );
  }
}
