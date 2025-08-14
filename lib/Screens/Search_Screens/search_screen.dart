
import 'package:flutter/material.dart';
import '../../Common_Widgets/custom_search_container.dart';
import 'Branches/search_branch_screen.dart';
import 'Exchange_Currency/exchange_currency_screen.dart';
import 'Exchange_Rate/exchange_rate_screen.dart';
import 'Interest_Rate/interest_rate_screen.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // so Flutter doesn't add its default back button
        title: Text('Search',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSearchContainer(title: 'Branch',subTitle: 'Search Branch', icon: 'assets/icons/branch.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>SearchBranchScreen()));
              }),
              SizedBox(height: 10,),
              customSearchContainer(title: 'Interest Rate',subTitle: 'Search for interest rate', icon: 'assets/icons/interest_rate.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>SearchInterestRateScreen()));
              }),
              SizedBox(height: 10,),
              customSearchContainer(title: 'Exchange Rate',subTitle: 'Search for exchange rate', icon: 'assets/icons/exchange_rate.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>ExchangeRateScreen()));
              }),
              SizedBox(height: 10,),
              customSearchContainer(title: 'Exchange',subTitle: 'Exchange you currency', icon: 'assets/icons/exchange_money.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>ExchangeScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
