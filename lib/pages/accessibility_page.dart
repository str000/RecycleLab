//Plugins
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets
import 'package:auth/widgets/top_bar.dart';
import 'package:auth/widgets/nav_bar.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
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
            Text('Accessibility'),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
