import 'package:flutter/material.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  String _fromCurrency = 'USD';
  String _toCurrency = 'KRW';

  final List<Map<String, String>> _currencyData = [
    {'code': 'USD', 'country': 'United States'},
    {'code': 'PKR', 'country': 'Pakistan'},
    {'code': 'KRW', 'country': 'South Korea'},
    {'code': 'EUR', 'country': 'European Union'},
    {'code': 'GBP', 'country': 'United Kingdom'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'exchange',
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            width: 327,
            height: 213,
            child: Image.asset('assets/images/exchange_currency_logo.png',
                fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildCurrencyRow('from', _fromController,
                        _fromCurrency, (val) {
                          setState(() => _fromCurrency = val);
                        }),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_downward,
                            color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_upward, color: Colors.red, size: 20),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildCurrencyRow(
                        'to', _toController, _toCurrency, (val) {
                      setState(() => _toCurrency = val);
                    }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'rate',
                          style:
                          TextStyle(color: Colors.blue[900], fontSize: 14),
                        ),
                        const Spacer(),
                        const Text(
                          '1 USD = 1122 KRW',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Exchange logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF433BFB),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'exchange',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyRow(String label,
      TextEditingController controller,
      String selectedCurrency,
      ValueChanged<String> onCurrencyChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
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
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'amount',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                height: 30,
                width: 1.5,
                color: Colors.grey[400],
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              GestureDetector(
                onTap: () => _showCurrencyDialog(onCurrencyChanged),
                child: Row(
                  children: [
                    Text(
                      selectedCurrency,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCurrencyDialog(ValueChanged<String> onSelected) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController searchController = TextEditingController();
        List<Map<String, String>> filteredList = List.from(_currencyData);

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('selectCurrency'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'search',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (query) {
                      setState(() {
                        filteredList = _currencyData.where((currency) {
                          final code = currency['code']!.toLowerCase();
                          final country = currency['country']!.toLowerCase();
                          return code.contains(query.toLowerCase()) ||
                              country.contains(query.toLowerCase());
                        }).toList();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final currency = filteredList[index];
                        return ListTile(
                          title: Text(
                            '${currency['code']} - ${currency['country']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          onTap: () {
                            onSelected(currency['code']!);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
