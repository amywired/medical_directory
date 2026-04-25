import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_directory/screens/welcom/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // =========================
        // 🔥 STATUS BAR FIX (IMPORTANT)
        // =========================
        statusBarColor:
            isDark ? const Color(0xFF0D1412) : Colors.white,

        statusBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,

        statusBarBrightness:
            isDark ? Brightness.dark : Brightness.light,

        // =========================
        // 🔥 NAVIGATION BAR FIX
        // =========================
        systemNavigationBarColor:
            isDark ? const Color(0xFF0D1412) : Colors.white,

        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medical Directory Mila',

        // =========================
        // 🌞 LIGHT THEME
        // =========================
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00695C),
            primary: const Color(0xFF00695C),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF00695C),
            foregroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),

        // =========================
        // 🌙 DARK THEME
        // =========================
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF70FFD8),
            brightness: Brightness.dark,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0D1412),
            foregroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),

        themeMode: _themeMode,

        home: const WelcomeScreen(),
      ),
    );
  }
}