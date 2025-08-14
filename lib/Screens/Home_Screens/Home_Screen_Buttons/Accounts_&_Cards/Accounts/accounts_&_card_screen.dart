import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../Common_Widgets/custom_single_card.dart';
import '../Cards/cards_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isAccountSelected = true; // This will track which tab is active

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
          "Account and card",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Account / Card Switch Buttons
            Row(
              children: [
                _buildTabButton("Account", isAccountSelected, () {
                  setState(() => isAccountSelected = true);
                }),
                const SizedBox(width: 10),
                _buildTabButton("Card", !isAccountSelected, () {

                  setState(() => isAccountSelected = false);
                }),
              ],
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      if (isAccountSelected) ...[
                        // Profile Image
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:  AssetImage('assets/images/profile_img.jpeg',),// Replace
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
                        const SizedBox(height: 20),
                        // Show Account list for now (later we will show Cards)

                        _accountTile(
                            "Account 1", "1900 8988 1234", "\$20,000", "New York"),
                        _accountTile("Account 2", "8988 1234", "\$12,000", "New York"),
                        _accountTile(
                            "Account 3", "1900 1234 2222", "\$230,000", "New York"),
                      ] else ...[
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
                        const SizedBox(height: 20),
                        SizedBox(

                          width: context.screenWidth-80,
                          child: ElevatedButton(
                            onPressed:
                                () {
                            }, // Disabled when form not valid
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: Colors.blue[900],
                              disabledBackgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Add Card',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _accountTile(
      String title, String accountNumber, String balance, String branch) {
    return Container(

      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 4),
              Text(accountNumber,
                  style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Available balance",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text(balance,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          ),

          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Branch",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text(branch,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
