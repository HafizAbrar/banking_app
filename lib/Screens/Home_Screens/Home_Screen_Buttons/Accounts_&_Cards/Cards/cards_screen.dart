
import 'package:flutter/material.dart';

import '../../../../../Common_Widgets/custom_single_card.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Account and Card",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          CustomSingleCard(
              ownerName: 'Sabri Sahib',
              cardName: 'Amazon Platinum',
              cardNumber: '1234 **** **** 3456',
              balance: '\$20,000',
              cardImage: 'assets/images/master_card.png'),
          //const SizedBox(height: 15),
          CustomSingleCard(
              ownerName: 'Sabri Sahib',
              cardName: 'Amazon Platinum',
              cardNumber: '1234 **** **** 3456',
              balance: '\$15,000',
              cardImage: 'assets/images/visa_card.png'),
          const SizedBox(height: 80), // Space for bottom button
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              // Add card action
            },
            child: const Text(
              "Add card",
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
