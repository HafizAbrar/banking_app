
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:app_settings/app_settings.dart';
import 'package:local_auth/local_auth.dart';

import '../../Common_Widgets/custom_setting_container.dart';
import 'AppInfo/app_information_screen.dart';
import 'Languages/selact_language_screen.dart';
import 'Password/update_password_screen.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();
  bool hasFingerprint = false;

  @override
  void initState() {
    super.initState();
    _checkFingerprintEnrolled();
  }

  Future<void> _checkFingerprintEnrolled() async {
    try {
      // Get available biometrics
      List<BiometricType> biometrics = await auth.getAvailableBiometrics();

      // Check if fingerprint exists
      bool enrolled = biometrics.contains(BiometricType.fingerprint);

      setState(() {
        hasFingerprint = enrolled;
      });
    } catch (e) {
      print("Error checking fingerprint: $e");
    }
  }

  void _openFingerprintSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.generalSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false, // so Flutter doesn't add its default back button
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 20), // space between avatar and title
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          centerTitle: false,
        ),
      ),
       body: Stack(
      clipBehavior: Clip.none, // allow the avatar to overflow outside the stack
      children: [
        // Main white container
        Container(
          margin: EdgeInsets.only(top: 50), // push container down so avatar overlaps nicely
          height: context.screenHeight * 0.8,
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
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              // top padding increased to leave space for avatar inside
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text(
                      'Sabri Sahib',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 20,),
                    customSettingContainer(title: 'Password',onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePasswordScreen()));
                    },icon: Icon(Icons.edit_outlined)),
                    SizedBox(height:1,),
                    customSettingContainer(title: 'Touch ID',onPress:  _openFingerprintSettings,icon: Icon(Icons.edit_outlined)),
                    SizedBox(height:1,),
                    customSettingContainer(title: 'Languages',onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectLanguageScreen()));
                    },icon: Icon(Icons.edit_outlined)),
                    SizedBox(height:1,),
                    customSettingContainer(title: 'App Information',onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AppInformationScreen()));
                    }),
                    SizedBox(height:1,),
                    customSettingContainer(title: 'Contact Us',contactNumber: '03049891921'),



                    // your settings form widgets here
                  ],
                ),
              ),
            ),
          ),
        ),
        // Positioned CircleAvatar
        Positioned(
          top: 0, // avatar will overlap container
          left: MediaQuery.of(context).size.width / 2 - 50, // center horizontally
          child: CircleAvatar(
            radius: 50, // size: adjust as needed
            backgroundColor: Colors.blue[900],
            backgroundImage: AssetImage('assets/images/profile_img.jpeg'),
          ),
        ),
      ],
    ),
    );
  }
}
