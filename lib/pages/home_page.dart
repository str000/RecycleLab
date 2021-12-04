//Plugins
import 'package:auth/utils/data_models.dart';
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_database/firebase_database.dart';
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
  var retrievedName = {};
  List<Test> companyList = [];

  @override
  void initState() {
    final ref = FirebaseDatabase.instance.reference();

    ref.onValue.listen((event) {
      var data = event.snapshot;
      setState(() {
        retrievedName = data.value['L1'];
      });
      print(retrievedName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(retrievedName['Name'].toString()),
          Text(retrievedName['Tel'].toString()),
        ],
      ),
    );
  }
}
