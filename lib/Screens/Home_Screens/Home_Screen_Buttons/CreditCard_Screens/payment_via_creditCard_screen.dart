import 'package:flutter/material.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/CreditCard_Screens/payment_confirmed_screen.dart';
import '../../../../Common_Widgets/custom_selection_field.dart';
import '../../../../Common_Widgets/custom_textfield.dart';

class Transaction {
  final IconData icon;
  final Color color;
  final String title;
  final String date;
  final String amount;

  Transaction({
    required this.icon,
    required this.color,
    required this.title,
    required this.date,
    required this.amount,
  });
}

class PaymentViaCreditCardScreen extends StatefulWidget {
  const PaymentViaCreditCardScreen({super.key});

  @override
  State<PaymentViaCreditCardScreen> createState() => _PaymentViaCreditCardScreenState();
}

class _PaymentViaCreditCardScreenState extends State<PaymentViaCreditCardScreen> {
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

  final List<Transaction> transactions = [
    Transaction(
      icon: Icons.camera_alt,
      color: Colors.blue,
      title: 'Buy Camera',
      date: '02/11/2018',
      amount: '-\$1200',
    ),
    Transaction(
      icon: Icons.tv,
      color: Colors.pink,
      title: 'Buy Television',
      date: '02/11/2018',
      amount: '-\$1500',
    ),
    Transaction(
      icon: Icons.phone_android,
      color: Colors.indigo,
      title: 'Buy Mobile',
      date: '03/11/2018',
      amount: '-\$800',
    ),
    Transaction(
      icon: Icons.laptop_mac,
      color: Colors.orange,
      title: 'Buy Laptop',
      date: '04/11/2018',
      amount: '-\$2000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double total = transactions.fold(
      0,
          (sum, item) =>
      sum + double.parse(item.amount.replaceAll(RegExp(r'[^0-9.]'), '')),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Credit Card',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Transactions List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final t = transactions[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: t.color,
                        child: Icon(t.icon, color: Colors.white),
                      ),
                      title: Text(
                        t.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        t.date,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        t.amount,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 5),

              // Total Row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TOTAL",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "-\$$total",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.pink,
                      ),
                    ),
                  ],
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
                      MaterialPageRoute(builder: (context) => ConfirmPaymentForPurchasesScreen()),
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
      ),
    );
  }
}
