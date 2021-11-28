//Plugins
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Home'),
        ],
      ),
    );
  }
}
