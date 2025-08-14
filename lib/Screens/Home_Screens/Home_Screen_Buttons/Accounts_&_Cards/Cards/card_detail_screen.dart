import 'package:flutter/material.dart';

class CardDetailScreen extends StatefulWidget {
  final String cardNumber;
  final String ownerName;
  final String validFrom;
  final String validTo;
  final double availableBalance;

  const CardDetailScreen({
    super.key,
    required this.cardNumber,
    required this.ownerName,
    required this.validFrom,
    required this.validTo,
    required this.availableBalance,
  });

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  bool updateChecked = false;
  bool deleteChecked = false;

  Widget _buildRow(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxInAppBar(String title, bool value, VoidCallback onTap) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (_) => onTap(),
        ),
        Text(title, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Card Details",
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0), // Add space here
              child: Row(
                children: [
                  _buildCheckboxInAppBar("Update", updateChecked, () {
                    setState(() {
                      updateChecked = true;
                      deleteChecked = false;
                    });
                  }),
                  _buildCheckboxInAppBar("Delete", deleteChecked, () {
                    setState(() {
                      updateChecked = false;
                      deleteChecked = true;
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildRow("Card Number", widget.cardNumber),
            const SizedBox(height: 8),
            _buildRow("Owner Name", widget.ownerName),
            const SizedBox(height: 8),
            _buildRow("Valid From", widget.validFrom),
            const SizedBox(height: 8),
            _buildRow("Valid To", widget.validTo),
            const SizedBox(height: 8),
            _buildRow(
                "Available Balance", "\$${widget.availableBalance.toStringAsFixed(2)}"),
            const SizedBox(height: 40),
            // Single Full-width Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (updateChecked || deleteChecked)
                    ? () {
                  if (updateChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Update clicked")),
                    );
                  } else if (deleteChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Delete clicked")),
                    );
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (updateChecked || deleteChecked)
                      ? (updateChecked ? Colors.blue : Colors.red)
                      : Colors.grey[300],
                ),
                child: Text(
                  updateChecked
                      ? "Update"
                      : deleteChecked
                      ? "Delete"
                      : "Select Action",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: (updateChecked || deleteChecked)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
