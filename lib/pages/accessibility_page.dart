//Plugins
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Accessibility'),
        ],
      ),
    );
  }
}
