import 'package:flutter/material.dart';

import '../../../../Common_Widgets/custom_textfield.dart';
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
  String? selectedAccount;
  int _selectedBeneficiaryIndex = -1; // -1 means none selected

  final List<String> accounts = [
    '1234567890',
    '9876543210',
    '1122334455',
  ];
  final List<Map<String, String?>> _beneficiaries = [
    { 'name': null, 'imageUrl': null }, // Add button
    { 'name': 'Hafiz', 'imageUrl': 'assets/images/profile_img.jpeg' },
    { 'name': 'Abrar', 'imageUrl': 'assets/images/profile_img.jpeg' },
    { 'name': 'Sabri', 'imageUrl': 'assets/images/profile_img.jpeg' },
  ];

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_updateState);
    _nameController.addListener(_updateState);
    _cardNumberController.addListener(_updateState);
    _amountController.addListener(_updateState);
    _contentController.addListener(_updateState);
  }
  void _updateState() {
    setState(() {}); // Refresh to enable/disable Verify button
  }
  void _showAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Select Account',style: TextStyle(color: Colors.black,fontSize: 16),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: accounts.map((acc) {
              return ListTile(
                title: Text(acc,style: const TextStyle(color: Colors.black,fontSize: 14),),
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
  Widget _transactionSwiperItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100, // Fixed width for consistency
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue[900] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: selected ? Colors.white : Colors.grey[800],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
    Widget _beneficiarySwiperItem({
    String? name,
    String? imageUrl,
    bool selected = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue[900] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[300],
              backgroundImage: imageUrl != null ? AssetImage(imageUrl) : null,
              child: imageUrl == null
                  ? const Icon(Icons.add, color: Colors.grey, size: 28)
                  : null,
            ),
            if (name != null) ...[
              const SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
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
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      controller: _accountController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          onPressed: _showAccountDialog,
                        ),
                        hintText: 'choose account/card',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.grey[500]),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 110, // height of swiper area
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _transactionSwiperItem(
                    icon: Icons.credit_card,
                    label: "Transfer via card number",
                    selected: selectedTransaction == 0,
                    onTap: () {
                      setState(() {
                        selectedTransaction = 0;
                      });
                    },
                  ),
                  _transactionSwiperItem(
                    icon: Icons.person,
                    label: "Transfer to same bank",
                    selected: selectedTransaction == 1,
                    onTap: () {
                      setState(() {
                        selectedTransaction = 1;
                      });
                    },
                  ),
                  _transactionSwiperItem(
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.grey[500]),
                ),
                TextButton(
                  onPressed: () {},
                  child:  Text(
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
                  return _beneficiarySwiperItem(
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
            CustomTextField(
              controller: _nameController,
              hintText: 'Name',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _cardNumberController,
              hintText: 'Card number',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _amountController,
              hintText: 'Amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _contentController,
              hintText: 'Transfer reason/content',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            // Checkbox
            Row(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(color: saveToDirectory ? Colors.blue[900]! : Colors.grey[400]!, width: 2),
                      fillColor: WidgetStateProperty.all(Colors.white),
                      checkColor: WidgetStateProperty.all(Colors.blue[900]),
                    ),
                  ),
                  child: Checkbox(
                    value: saveToDirectory,
                    onChanged: (value) {
                      setState(() {
                        saveToDirectory = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 6),
                 Text(
                  "Save to directory of beneficiary",
                  style: TextStyle(fontSize: 14,color: Colors.grey[500]),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConfirmTransferScreen(
                        senderAccount: "1234-5678-9012",
                        beneficiaryName: "John Doe",
                        beneficiaryAccount: "9876-5432-1098",
                        transferContent: "Payment for services",
                        amount: 15000.50,
                      ),
                    ),
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text(
                  "Proceed",
                  style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
