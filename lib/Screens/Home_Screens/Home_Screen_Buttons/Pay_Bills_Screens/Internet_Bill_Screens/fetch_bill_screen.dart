import 'package:flutter/material.dart';
import 'package:mobile_banking/Common_Widgets/custom_selection_field.dart';
import 'package:mobile_banking/Common_Widgets/custom_textfield.dart';

import 'bill_detail_screen.dart';

class FetchInternetBillScreen extends StatefulWidget {
  const FetchInternetBillScreen({super.key});

  @override
  State<FetchInternetBillScreen> createState() => _FetchInternetBillScreenState();
}

class _FetchInternetBillScreenState extends State<FetchInternetBillScreen> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _billNumberController = TextEditingController();

  bool _isFormValid = false;

  final List<String> internetCompanies = [
    "PTCL - Pakistan Telecommunication Company Limited",
    "StormFiber - Fiber Internet",
    "Nayatel - Fiber Internet",
    "Optix - Fiber Internet",
    "Transworld Home - Internet Services",
    "Wi-Tribe Pakistan",
    "WorldCall Internet",
    "Multinet Pakistan",
    "Qubee Pakistan",
    "Zong 4G Internet",
    "Jazz 4G Internet",
    "Telenor 4G Internet",
    "Ufone 4G Internet",
  ];



  @override
  void initState() {
    super.initState();
    _companyNameController.addListener(_validate);
    _billNumberController.addListener(_validate);
  }

  void _validate() {
    setState(() {
      _isFormValid = _companyNameController.text.isNotEmpty &&
          _billNumberController.text.isNotEmpty&&_billNumberController.text.length==9;
    });
  }

  void _showCompanyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Select Company",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: internetCompanies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(internetCompanies[index]),
                  onTap: () {
                    setState(() {
                      _companyNameController.text = internetCompanies[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _billNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Fetch Bill',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSelectionField(
                  controller: _companyNameController,
                  hintText: 'Choose company',
                  onTapSuffix: _showCompanyDialog,
                ),
                const SizedBox(height: 16),
                Text('Bill reference',style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: _billNumberController,
                    hintText: 'Enter bill number'),
                const SizedBox(height: 20),
                Text('please select correct reference number to fetch the bill',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),),
                SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      _isFormValid ? Colors.blue[900] : Colors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _isFormValid
                        ? () {
                      // fetch bill logic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InternetBillDetailsScreen(
                            referenceNumber: _billNumberController.text,
                          ),
                        ),
                      );
                    }
                        : null,
                    child: const Text("Fetch Bill"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
