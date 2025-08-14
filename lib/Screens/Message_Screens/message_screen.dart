
import 'package:flutter/material.dart';

import '../../Common_Widgets/custom_message_container.dart';
class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // so Flutter doesn't add its default back button
        title: Text('Messages',style: TextStyle(
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
              customMessageContainer(title: 'Bank of America',subTitle: 'Search Branch', icon: 'assets/icons/bank.png',day: 'Today', onPress: (){}),
              SizedBox(height: 10,),
              customMessageContainer(title: 'Account',subTitle: 'Search for interest rate', icon: 'assets/icons/person.png',day: 'Today', onPress: (){}),
              SizedBox(height: 10,),
              customMessageContainer(title: 'Alert',subTitle: 'Search for exchange rate', icon: 'assets/icons/alert.png',day: 'Today', onPress: (){}),
              SizedBox(height: 10,),
              customMessageContainer(title: 'Paypal',subTitle: 'Exchange you currency', icon: 'assets/icons/paypal.png',day: 'Today', onPress: (){}),
              SizedBox(height: 10,),
              customMessageContainer(title: 'Withdraw',subTitle: 'Exchange you currency', icon: 'assets/icons/withdraw_msg.png',day: 'Today', onPress: (){}),
            ],
          ),
        ),
      ),
    );
  }
}
