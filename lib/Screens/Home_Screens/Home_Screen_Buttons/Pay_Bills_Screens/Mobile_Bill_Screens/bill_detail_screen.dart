import 'package:flutter/material.dart';

import 'bill_payment_screen.dart';

class MobileBillDetailsScreen extends StatelessWidget {
  final String referenceNumber;

  const MobileBillDetailsScreen({super.key, required this.referenceNumber});

  @override
  Widget build(BuildContext context) {
    // Example data (replace with API result)
    final billData = {
      "mobileNumber": "03001234567",
      "customerName": "Ali Khan",
      "billingMonth": "August 2025",
      "billIssueDate": "01-09-2025",
      "dueDate": "10-09-2025",
      "previousBalance": 500,
      "packageCharges": 1500,
      "usageCharges": 820,
      "taxes": 350,
      "totalAmount": 3170,
      "status": "Unpaid"
    };

    Widget buildRow(String label, String value, {Color? valueColor}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.grey[600])),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Mobile Bill Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/withdraw_img.png',
                height: 188,
                width: 342,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildRow("Mobile Number", billData['mobileNumber'].toString()),
                    buildRow("Customer Name", billData['customerName'].toString()),
                    buildRow("Billing Month", billData['billingMonth'].toString()),
                    buildRow("Bill Issue Date", billData['billIssueDate'].toString()),
                    buildRow("Due Date", billData['dueDate'].toString()),
                    buildRow("Previous Balance", "Rs. ${billData['previousBalance']}"),
                    buildRow("Package Charges", "Rs. ${billData['packageCharges']}"),
                    buildRow("Usage Charges", "Rs. ${billData['usageCharges']}"),
                    buildRow("Taxes", "Rs. ${billData['taxes']}"),
                    buildRow("Total Amount", "Rs. ${billData['totalAmount']}"),
                    buildRow(
                      "Status",
                      billData['status'].toString(),
                      valueColor: billData['status'] == "Paid" ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 20),

                    // Pay Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MobileBillPaymentScreen(
                                referenceNumber: referenceNumber,
                              )),
                              );
                        },
                        child: const Text(
                          "Pay Bill",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
