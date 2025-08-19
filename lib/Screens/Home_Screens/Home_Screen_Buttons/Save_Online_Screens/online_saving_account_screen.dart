
import 'package:flutter/material.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Pay_Bills_Screens/Electric_Bill_Screens/fetch_bill_screen.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Pay_Bills_Screens/Gas_Bill_Screens/fetch_bill_screen.dart';
import 'package:mobile_banking/Screens/Home_Screens/Home_Screen_Buttons/Save_Online_Screens/Add_Accounts/addNew_saving_account.dart';

import '../../../../Common_Widgets/custom_search_container.dart';
class SavingAccountScreen extends StatefulWidget {
  const SavingAccountScreen({super.key});

  @override
  State<SavingAccountScreen> createState() => _SavingAccountScreenState();
}

class _SavingAccountScreenState extends State<SavingAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // so Flutter doesn't add its default back button
        title: Text('Saving AccountS',style: TextStyle(
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
              customSearchContainer(title: 'Add New Account',subTitle: 'add new online saving account', icon: 'assets/images/add_saving_acc_img.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>AddNewSavingAccountScreen()));
              }),
              SizedBox(height: 10,),
              customSearchContainer(title: 'Management',subTitle: 'manage your online saving account', icon: 'assets/images/mng_saving_acc_img.png', onPress: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>FetchGasBillScreen()));
              }),

            ],
          ),
        ),
      ),
    );
  }
}
