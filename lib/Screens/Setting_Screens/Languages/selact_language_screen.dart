import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Search_Screens/Exchange_Currency/exchange_currency_screen.dart';


class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  final List<Map<String, String>> _languages = [
    {'flag': 'assets/flags/us.svg', 'language': 'English'},
    {'flag': 'assets/flags/pk.svg', 'language': 'Urdu'},
    {'flag': 'assets/flags/sa.svg', 'language': 'Arabic'},
    {'flag': 'assets/flags/cn.svg', 'language': 'Chinese'},
    {'flag': 'assets/flags/fr.svg', 'language': 'French'},
    {'flag': 'assets/flags/de.svg', 'language': 'German'},
    {'flag': 'assets/flags/es.svg', 'language': 'Spanish'},
    {'flag': 'assets/flags/ru.svg', 'language': 'Russian'},
    {'flag': 'assets/flags/jp.svg', 'language': 'Japanese'},
    {'flag': 'assets/flags/tr.svg', 'language': 'Turkish'},
    {'flag': 'assets/flags/it.svg', 'language': 'Italian'},
    {'flag': 'assets/flags/in.svg', 'language': 'Hindi'},
    {'flag': 'assets/flags/bd.svg', 'language': 'Bengali'},
    {'flag': 'assets/flags/ph.svg', 'language': 'Filipino'},
    {'flag': 'assets/flags/id.svg', 'language': 'Indonesian'},
    {'flag': 'assets/flags/ir.svg', 'language': 'Persian'},
    {'flag': 'assets/flags/pt.svg', 'language': 'Portuguese'},
    {'flag': 'assets/flags/kr.svg', 'language': 'Korean'},
    {'flag': 'assets/flags/vn.svg', 'language': 'Vietnamese'},
    {'flag': 'assets/flags/uz.svg', 'language': 'Uzbek'},
    {'flag': 'assets/flags/az.svg', 'language': 'Azerbaijani'},
    {'flag': 'assets/flags/th.svg', 'language': 'Thai'},
    {'flag': 'assets/flags/gr.svg', 'language': 'Greek'},
    {'flag': 'assets/flags/ua.svg', 'language': 'Ukrainian'},
    {'flag': 'assets/flags/nl.svg', 'language': 'Dutch'},
    {'flag': 'assets/flags/se.svg', 'language': 'Swedish'},
    {'flag': 'assets/flags/no.svg', 'language': 'Norwegian'},
    {'flag': 'assets/flags/fi.svg', 'language': 'Finnish'},
    {'flag': 'assets/flags/dk.svg', 'language': 'Danish'},
    {'flag': 'assets/flags/cz.svg', 'language': 'Czech'},
    {'flag': 'assets/flags/pl.svg', 'language': 'Polish'},
    {'flag': 'assets/flags/hu.svg', 'language': 'Hungarian'},
    {'flag': 'assets/flags/ro.svg', 'language': 'Romanian'},
    {'flag': 'assets/flags/bg.svg', 'language': 'Bulgarian'},
    {'flag': 'assets/flags/il.svg', 'language': 'Hebrew'},
    {'flag': 'assets/flags/kz.svg', 'language': 'Kazakh'},
    {'flag': 'assets/flags/ge.svg', 'language': 'Georgian'},
    {'flag': 'assets/flags/am.svg', 'language': 'Armenian'},
    {'flag': 'assets/flags/kh.svg', 'language': 'Khmer'},
    {'flag': 'assets/flags/my.svg', 'language': 'Malay'},
  ];

  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Language',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Divider(height: 0.5),
          Expanded(
            child: ListView.separated(
              itemCount: _languages.length,
              separatorBuilder: (context, index) => const Divider(height: 0.5),
              itemBuilder: (context, index) {
                final language = _languages[index];
                return ListTile(
                  leading: SvgPicture.asset(language['flag']!, width: 32, height: 32),
                  title: Text(language['language']!, style: const TextStyle(fontSize: 16)),
                  trailing: _selectedLanguage == language['language']
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = language['language'];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
