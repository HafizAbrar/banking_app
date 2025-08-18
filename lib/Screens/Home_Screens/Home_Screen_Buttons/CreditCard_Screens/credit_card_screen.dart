import 'package:flutter/material.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/CreditCard_Screens/payment_via_creditCard_screen.dart';
import '../../../../Common_Widgets/custom_multi_card.dart';

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

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
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
      amount: '-\$1200',
    ),
    Transaction(
      icon: Icons.camera_alt,
      color: Colors.indigo,
      title: 'Buy Camera',
      date: '02/11/2018',
      amount: '-\$1200',
    ),
    Transaction(
      icon: Icons.tv,
      color: Colors.orange,
      title: 'Buy Television',
      date: '02/11/2018',
      amount: '-\$1200',
    ),
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double total = transactions.fold(
      0,
          (sum, item) =>
      sum + double.parse(item.amount.replaceAll(RegExp(r'[^0-9.]'), '')),
    );

    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            'Credit card',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
      ),
      body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Credit Card Widget
                Center(
                  child: CustomCard(
                    cardImage: 'assets/images/visa_card.png',
                    ownerName: 'Sabri Sahib',
                    cardName: 'Amazon Platinum',
                    cardNumber: '**** **** **** 1234',
                    balance: '\$10000',
                  ),
                ),
                const SizedBox(height: 20),

                // Transactions List
                Padding(
                  padding: const EdgeInsets.only(top: 12,left: 12,right: 12,bottom: 0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black12,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true, // Important for scrollable inside scroll
                      physics: const NeverScrollableScrollPhysics(),
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
                ),
                const SizedBox(height: 5),

                // Total Container
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 0,bottom: 10),
                  child: Container(
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
                ),
                const SizedBox(height: 40),

                // Pay button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentViaCreditCardScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Pay",
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
      ),
    ),
    );
  }
}
