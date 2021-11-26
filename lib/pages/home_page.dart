//Plugins
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
//Pages
//Utils
//Theme

//Widgets
import 'package:auth/widgets/top_bar.dart';
import 'package:auth/widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        height: 90,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
