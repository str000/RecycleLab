//Plugins
import 'package:auth/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Pages
import 'pages/signin_page.dart';
//Theme
import 'package:auth/theme/light_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ModeTheme.lightTheme,
      home: const LoginPage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl', 'PL'),
      ],
    );
  }
}
