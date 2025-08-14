
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Screens/Authentication_Screens/sign_in_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBgbDevOjbN4_wERY0UKqUYJgBj9nzPsNA",
        authDomain: "bank-database-8c2b8.firebaseapp.com",
        projectId: "bank-database-8c2b8",
        storageBucket: "bank-database-8c2b8.firebasestorage.app",
        messagingSenderId: "168147392330",
        appId: "1:168147392330:web:eeea452ec51467f2cb93b3",
        measurementId: "G-CE1E0Z501X",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E_Bank',

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.blue[900],
      ),
      home: SignInScreen(),
    );
  }
}

