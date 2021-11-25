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

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
