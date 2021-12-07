//Plugins
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_database/firebase_database.dart';
//Pages
//Utils
//Theme
import 'package:auth/theme/text.dart';
import 'package:auth/theme/colors.dart';
//Widgets
import 'package:auth/widgets/sign_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseDatabase.instance.reference();
  //final User? _currentUser = FirebaseAuth.instance.currentUser;

  List _needs = [];

  getList() async {
    List needs = [];

    ref.child('posts').onValue.listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      needs = [];
      values.forEach((key, values) {
        values['id'] = key;
        needs.add(values);
      });
      setState(() {
        _needs = needs;
      });
    });

    //print(_needs[0]['Name']);
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: ListView.builder(
                        itemCount: _needs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            _needs[index].toString(),
                            //_needs[index]['Name'].toString(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
