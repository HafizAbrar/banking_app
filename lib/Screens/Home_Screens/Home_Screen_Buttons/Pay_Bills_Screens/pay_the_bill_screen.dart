
import 'package:flutter/material.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Pay_Bills_Screens/Electric_Bill_Screens/fetch_bill_screen.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Pay_Bills_Screens/Gas_Bill_Screens/fetch_bill_screen.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Pay_Bills_Screens/Internet_Bill_Screens/fetch_bill_screen.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Pay_Bills_Screens/Mobile_Bill_Screens/fetch_bill_screen.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Transfer_Screens/face_id_checker_screen.dart';

import '../../../../Common_Widgets/custom_search_container.dart';
class BillPaymentMainScreen extends StatefulWidget {
  const BillPaymentMainScreen({super.key});

  @override
  State<BillPaymentMainScreen> createState() => _BillPaymentMainScreenState();
}

class _BillPaymentMainScreenState extends State<BillPaymentMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // so Flutter doesn't add its default back button
        title: Text('Bill Payment',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSearchContainer(title: 'Electric Bill',subTitle: 'pay the electric bill of this month', icon: 'assets/images/electric_bill_img.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>FetchElectricBillScreen()));
              }),
              SizedBox(height: 10,),
              customSearchContainer(title: 'Gas Bill',subTitle: 'Pay your gas bill of this month', icon: 'assets/images/gas_bill_img.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>FetchGasBillScreen()));
              }),
              SizedBox(height: 10,),
              customSearchContainer(title: 'Mobile Bill',subTitle: 'Pay your mobile bill of this month', icon: 'assets/images/mobile_bill_img.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>FetchMobileBillScreen()));
              }),
              SizedBox(height: 10,),
              customSearchContainer(title: 'Internet Bill',subTitle: 'pay your internet bill of this month', icon: 'assets/images/internet_bill_img.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>FetchInternetBillScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
