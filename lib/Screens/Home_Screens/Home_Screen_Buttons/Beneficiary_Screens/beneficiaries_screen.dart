import 'package:flutter/material.dart';

import 'addNew_beneficiary_screen.dart';

class Beneficiary {
  final String name;
  final String accountNumber;
  final String imageUrl;

  Beneficiary({
    required this.name,
    required this.accountNumber,
    required this.imageUrl,
  });
}

class BeneficiaryScreen extends StatefulWidget {
  const BeneficiaryScreen({super.key});

  @override
  State<BeneficiaryScreen> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> {
  // Dummy beneficiaries
  final List<Beneficiary> cardBeneficiaries = [
    Beneficiary(name: "Hafiz", accountNumber: "1278980890", imageUrl: "assets/images/profile_img.jpeg"),
    Beneficiary(name: "Abrar", accountNumber: "0345976231", imageUrl: "assets/images/profile_img.jpeg"),
  ];

  final List<Beneficiary> sameBankBeneficiaries = [
    Beneficiary(name: "Ahmad", accountNumber: "1278980890", imageUrl: "assets/images/profile_img.jpeg"),
    Beneficiary(name: "Musa", accountNumber: "0345976231", imageUrl: "assets/images/profile_img.jpeg"),
  ];

  final List<Beneficiary> otherBankBeneficiaries = [
    Beneficiary(name: "Tahir", accountNumber: "1278980890", imageUrl: "assets/images/profile_img.jpeg"),
    Beneficiary(name: "Khurram", accountNumber: "0345976231", imageUrl: "assets/images/profile_img.jpeg"),
    Beneficiary(name: "Nadeem", accountNumber: "0345976231", imageUrl: "assets/images/profile_img.jpeg"),
  ];

  // Helper: all beneficiaries in one list
  List<Beneficiary> get allBeneficiaries =>
      [...cardBeneficiaries, ...sameBankBeneficiaries, ...otherBankBeneficiaries];

  Widget _buildSection(List<Beneficiary> beneficiaries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...beneficiaries.map((b) => ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(b.imageUrl),
          ),
          title: Text(b.name, style: const TextStyle(
              color:Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
          subtitle: Text(b.accountNumber,
              style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          onTap: () {
            // Handle tap - maybe navigate to transfer screen
          },
        )),
        const SizedBox(height: 10),
      ],
    );
  }

  void _showSearchDialog() {
    TextEditingController searchController = TextEditingController();
    List<Beneficiary> filteredList = List.from(allBeneficiaries);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text("Search Beneficiary"),
            content: SizedBox(
              width: double.maxFinite, // take available width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Enter name or account number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // <-- Rounded corners
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    onChanged: (value) {
                      setStateDialog(() {
                        filteredList = allBeneficiaries.where((b) {
                          final query = value.toLowerCase();
                          return b.name.toLowerCase().contains(query) ||
                              b.accountNumber.contains(query);
                        }).toList();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: filteredList.isEmpty
                        ? const Center(child: Text("No results found"))
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final b = filteredList[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(b.imageUrl),
                          ),
                          title: Text(b.name),
                          subtitle: Text(b.accountNumber),
                          onTap: () {
                            Navigator.pop(context); // close dialog
                            // Navigate or do something with selected beneficiary
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Beneficiary", style: TextStyle(
            fontSize:20,color:  Colors.black,
        fontWeight: FontWeight.bold
        )),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:  16),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: _showSearchDialog,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text('Transfer via card number',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 10),
              _buildCard(cardBeneficiaries),
              const SizedBox(height: 10),
              Text('Transfer via same bank',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 10),
              _buildCard(sameBankBeneficiaries),
              const SizedBox(height: 10),
              Text('Transfer via other bank',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 10),
              _buildCard(otherBankBeneficiaries),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewBeneficiaryScreen()),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCard(List<Beneficiary> list) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSection(list),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
