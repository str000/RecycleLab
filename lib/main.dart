//Plugins
import 'package:flutter/material.dart';
//Pages
import 'pages/signin_page.dart';
//Theme
import 'package:auth/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nazwa Apki',
      debugShowCheckedModeBanner: false,
      theme: ModeTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
