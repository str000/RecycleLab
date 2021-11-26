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

class LikedPage extends StatefulWidget {
  const LikedPage({Key? key}) : super(key: key);
  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        height: 90,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Liked'),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
