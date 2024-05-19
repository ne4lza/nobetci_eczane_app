import 'package:flutter/material.dart';
import 'package:nobetci_eczane/core/themes/theme.dart';
import 'package:nobetci_eczane/features/pages/home.dart';

class EczaneApp extends StatelessWidget {
  const EczaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eczane',
      theme: lightMode,
      darkTheme: darkMode,
      home: const Home(),
    );
  }
}