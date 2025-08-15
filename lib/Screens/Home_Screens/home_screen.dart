import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Common_Widgets/custom_button.dart';
import '../../Common_Widgets/custom_multi_card.dart';
import 'Home_Screen_Buttons/Accounts_&_Cards/Accounts/accounts_&_card_screen.dart';
import 'Home_Screen_Buttons/Transfer_Screens/transfer_screen.dart';
import 'Home_Screen_Buttons/Withdraw/withdraw_specificAmount_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false, // so Flutter doesn't add its default back button
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 20), // adjust as needed
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                // radius 100 is huge; use 20~30 usually
                backgroundColor: Colors.blue[900],
                backgroundImage: AssetImage('assets/images/profile_img.jpeg'),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 20), // space between avatar and title
            child: Text(
              'Salam! Sabri sahib',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0,top: 20), // right space
              child: IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // handle action
                },
              ),
            ),
          ],
          centerTitle: false,
        ),
      ),
      body: Container(
        //height: context.screenHeight*0.8,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),

        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,20),
            child: Form(
              // Using a Form widget for better structure and potential validation
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the column content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Stretch children to fill horizontal space
                children: <Widget>[
                  CustomCard(
                    cardImage: 'assets/images/visa_card.png',
                    ownerName: 'Sabri Sahib',
                    cardName: 'Amazon Platinum',
                    cardNumber: '**** **** **** 1234',
                    balance: '\$10000',
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customButton(title: 'Account and Card', icon:'assets/icons/wellet.png' , onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountScreen()));
                      }),
                      SizedBox(width: 10,),
                      customButton(title: 'Transfer', icon:'assets/icons/transfer.png' , onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TransferScreen()));
                      }),
                      SizedBox(width: 10,),
                      customButton(title: 'Withdraw', icon:'assets/icons/withdraw.png' , onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WithdrawScreen()));
                      }),
                     ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customButton(title: 'Mobile Prepaid', icon:'assets/icons/prepaid.png' , onPress: (){}),
                      SizedBox(width: 10,),
                      customButton(title: 'Pay the bill', icon:'assets/icons/pay_the_bill.png' , onPress: (){}),
                      SizedBox(width: 10,),
                      customButton(title: 'Save Online', icon:'assets/icons/online.png' , onPress: (){}),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customButton(title: 'Credit Card', icon:'assets/icons/credit-card.png' , onPress: (){}),
                      SizedBox(width: 10,),
                      customButton(title: 'Transaction Report', icon:'assets/icons/transaction_report.png' , onPress: (){}),
                      SizedBox(width: 10,),
                      customButton(title: 'Beneficiary', icon:'assets/icons/beneficiary.png' , onPress: (){}),
                    ],
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
