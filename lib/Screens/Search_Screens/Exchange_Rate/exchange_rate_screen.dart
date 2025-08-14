import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({super.key});

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  final List<Map<String, String>> _exchangeRates = [
    {'flag': 'assets/flags/pk.svg', 'country': 'Pakistan', 'buy': '277.50', 'sell': '279.00'},
    {'flag': 'assets/flags/us.svg', 'country': 'USA', 'buy': '1.00', 'sell': '1.00'},
    {'flag': 'assets/flags/gb.svg', 'country': 'United Kingdom', 'buy': '0.78', 'sell': '0.80'},
    {'flag': 'assets/flags/eu.svg', 'country': 'Eurozone', 'buy': '0.91', 'sell': '0.93'},
    {'flag': 'assets/flags/ca.svg', 'country': 'Canada', 'buy': '1.34', 'sell': '1.36'},
    {'flag': 'assets/flags/ae.svg', 'country': 'UAE', 'buy': '3.66', 'sell': '3.68'},
    {'flag': 'assets/flags/sa.svg', 'country': 'Saudi Arabia', 'buy': '3.74', 'sell': '3.76'},
    {'flag': 'assets/flags/in.svg', 'country': 'India', 'buy': '82.50', 'sell': '83.00'},
    {'flag': 'assets/flags/cn.svg', 'country': 'China', 'buy': '7.18', 'sell': '7.20'},
    {'flag': 'assets/flags/jp.svg', 'country': 'Japan', 'buy': '143.50', 'sell': '144.20'},
    {'flag': 'assets/flags/au.svg', 'country': 'Australia', 'buy': '1.49', 'sell': '1.51'},
    {'flag': 'assets/flags/nz.svg', 'country': 'New Zealand', 'buy': '1.61', 'sell': '1.63'},
    {'flag': 'assets/flags/ch.svg', 'country': 'Switzerland', 'buy': '0.90', 'sell': '0.92'},
    {'flag': 'assets/flags/br.svg', 'country': 'Brazil', 'buy': '4.85', 'sell': '4.90'},
    {'flag': 'assets/flags/za.svg', 'country': 'South Africa', 'buy': '18.10', 'sell': '18.30'},
    {'flag': 'assets/flags/my.svg', 'country': 'Malaysia', 'buy': '4.65', 'sell': '4.68'},
    {'flag': 'assets/flags/sg.svg', 'country': 'Singapore', 'buy': '1.34', 'sell': '1.36'},
    {'flag': 'assets/flags/tr.svg', 'country': 'Turkey', 'buy': '27.50', 'sell': '27.80'},
    {'flag': 'assets/flags/kr.svg', 'country': 'South Korea', 'buy': '1290.00', 'sell': '1300.00'},
    {'flag': 'assets/flags/th.svg', 'country': 'Thailand', 'buy': '34.00', 'sell': '34.20'},
    {'flag': 'assets/flags/id.svg', 'country': 'Indonesia', 'buy': '14900.00', 'sell': '14950.00'},
    {'flag': 'assets/flags/ph.svg', 'country': 'Philippines', 'buy': '56.00', 'sell': '56.30'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates',
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
                  flex: 4,
                  child: Text('Country',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 14)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('Buy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 16)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('Sell',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 16)),
                ),
              ],
            ),
          ),
          const Divider(),
          // List of exchange rates
          Expanded(
            child: ListView.separated(
              itemCount: _exchangeRates.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = _exchangeRates[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              item['flag'] ?? '',
                              width: 30,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(item['country'] ?? '',
                                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(item['buy'] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(item['sell'] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.red,fontWeight: FontWeight.bold)),
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
