import 'package:flutter/material.dart';
import 'package:medical_directory/screens/home_screen.dart';

void main() {
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryMint = Color(0xFF70FFD8);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Directory Mila',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryMint,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryMint,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryMint,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryMint,
          foregroundColor: Colors.black,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}