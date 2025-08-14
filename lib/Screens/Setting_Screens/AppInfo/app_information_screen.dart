import 'package:flutter/material.dart';

import '../../../Common_Widgets/appinfo_tile.dart';

class AppInformationScreen extends StatefulWidget {
  const AppInformationScreen({super.key});

  @override
  State<AppInformationScreen> createState() => _AppInformationScreenState();
}

class _AppInformationScreenState extends State<AppInformationScreen> {
  String selectedLanguage = "English"; // This could come from your app settings

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'App Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              '@ApnaBank E_Banking',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Reusable Info Tiles
          const InfoTile(
            icon: Icons.calendar_today,
            title: "Date of Manufacture",
            value: "10 Aug 2025",
          ),
          const InfoTile(
            icon: Icons.verified,
            title: "Version",
            value: "1.0.0",
          ),
          const InfoTile(
            icon: Icons.language,
            title: "Selected Language",
            value: "English",
          ),
        ],
      ),
    );
  }
}
