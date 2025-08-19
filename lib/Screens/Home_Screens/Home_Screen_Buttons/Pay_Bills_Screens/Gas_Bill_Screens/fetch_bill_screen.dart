import 'package:flutter/material.dart';
import 'package:mobile_banking/Common_Widgets/custom_selection_field.dart';
import 'package:mobile_banking/Common_Widgets/custom_textfield.dart';

import 'bill_detail_screen.dart';

class FetchGasBillScreen extends StatefulWidget {
  const FetchGasBillScreen({super.key});

  @override
  State<FetchGasBillScreen> createState() => _FetchGasBillScreenState();
}

class _FetchGasBillScreenState extends State<FetchGasBillScreen> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _billNumberController = TextEditingController();

  bool _isFormValid = false;

  final List<String> gasCompanies = [
    "SSGC - Sui Southern Gas Company",
    "SNGPL - Sui Northern Gas Pipelines Limited",
    "PGPC - Pakistan GasPort Consortium Limited",
    "Engro Elengy Terminal (LNG Import)",
    "PLL - Pakistan LNG Limited",
    "PPL - Pakistan Petroleum Limited",
    "OGDCL - Oil & Gas Development Company Limited",
    "Mari Petroleum Company Limited",
    "GHPL - Government Holdings (Private) Limited",
    "KUFPEC Pakistan (Kuwait Foreign Petroleum Exploration)",
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
          _billNumberController.text.isNotEmpty&&_billNumberController.text.length==11;
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
              itemCount: gasCompanies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(gasCompanies[index]),
                  onTap: () {
                    setState(() {
                      _companyNameController.text = gasCompanies[index];
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
                          builder: (context) => GasBillDetailsScreen(
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
