
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Message_Screens/message_screen.dart';
import '../Search_Screens/search_screen.dart';
import '../Setting_Screens/setting_screen.dart';
import 'home_screen.dart';


class HomeNavigationScreen extends StatelessWidget {
  HomeNavigationScreen({super.key});

  // Observable variable for current index
  final RxInt currentNavIndex = 0.obs;

  // Navigation items
  final navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.mail_outlined), label: 'Message'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];

  // Screens corresponding to navigation items
  final navBody = [
    HomeScreen(),
    SearchScreen(),   // Show LoginScreen when Favourite is tapped
    MessageScreen(),
    SettingScreen(),
  ];
  Future<bool> _showExitDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
    return result ?? false;
  }
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false, // Prevent default pop until confirmed
      onPopInvoked: (didPop) async {
        if (!didPop) {
          bool shouldExit = await _showExitDialog(context);
          if (shouldExit) {
            SystemNavigator.pop(); // Exit the app
          }
        }
      },
      child:Scaffold(
      backgroundColor: Colors.transparent,

      // Display selected screen
      body: Obx(() => navBody[currentNavIndex.value]),

      // Bottom Navigation Bar
      bottomNavigationBar:Obx(()=>ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: BottomNavigationBar(
          currentIndex: currentNavIndex.value,
          backgroundColor: Colors.white,
          elevation: 4,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue[900],
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: TextStyle(fontFamily: 'poppins'),
          type: BottomNavigationBarType.fixed,
          items: navBarItems,
          onTap: (index) {
            currentNavIndex.value = index;
          },
        ),
      ),
      ),
      ),
    );
  }
}
