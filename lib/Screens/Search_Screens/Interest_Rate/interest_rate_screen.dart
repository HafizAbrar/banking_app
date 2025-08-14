import 'package:flutter/material.dart';

class SearchInterestRateScreen extends StatefulWidget {
  const SearchInterestRateScreen({super.key});

  @override
  State<SearchInterestRateScreen> createState() => _SearchInterestRateScreenState();
}

class _SearchInterestRateScreenState extends State<SearchInterestRateScreen> {
  // Initial static data
  final List<Map<String, String>> _interestRates = [
    {'kind': 'Individual customers', 'deposit': '1m', 'rate': '4.50%'},
    {'kind': 'Corporate customers', 'deposit': '2m', 'rate': '5.50%'},
    {'kind': 'Individual customers', 'deposit': '8m', 'rate': '6.50%'},
    {'kind': 'Corporate customers', 'deposit': '8m', 'rate': '2.50%'},
    {'kind': 'Individual customers', 'deposit': '7m', 'rate': '6.80%'},
    {'kind': 'Individual customers', 'deposit': '12m', 'rate': '5.90%'},
    {'kind': 'Individual customers', 'deposit': '1m', 'rate': '4.50%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interest rate',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Interest kind',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 16)),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Deposit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 16)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Expanded(
                    flex: 2,
                    child: Text('Rate',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // List
          Expanded(
            child: ListView.separated(
              itemCount: _interestRates.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = _interestRates[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(item['kind'] ?? '',
                            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(item['deposit'] ?? '',
                            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(item['rate'] ?? '',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.blue,fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
