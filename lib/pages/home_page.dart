//Plugins
import 'package:firebase_database/firebase_database.dart';
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
  var retrievedName;

  @override
  void initState() {
    final ref = FirebaseDatabase.instance.reference();

    ref.child("L2/Name").onValue.listen((event) {
      var data = event.snapshot;
      print(data.value);
      print(data.key);
      setState(() {
        retrievedName = data.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(retrievedName ?? ""),
        ],
      ),
    );
  }
}
