//Plugins
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//Firebase Package
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Pages
//Utils
//Theme
import 'package:auth/theme/text.dart';
//Widgets

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseDatabase.instance.reference();

  final User? _currentUser = FirebaseAuth.instance.currentUser;

  var retrievedName = {};

  late DateTime _chosenDate;
  bool _dateChosen = false;

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
      barrierDismissible: false,
      context: ctx,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Container(
          height: 347,
          color: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Podaj Datę Urodzenia',
                  style: signTextFormField,
                ),
              ),
              SizedBox(
                height: 245,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _dateChosen ? _chosenDate : DateTime.now(),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDate = val;
                        _dateChosen = true;
                      });
                    }),
              ),
              CupertinoButton(
                child: const Text(
                  'Potwierdź',
                  style: signTextFormField,
                ),
                onPressed: () {
                  setBirthdate();
                  Navigator.of(ctx).pop();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  setBirthdate() {
    ref.child('users/' + _currentUser!.uid).set({
      'date': _chosenDate.toString(),
    });
  }

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
    ref
        .child('users/' + _currentUser!.uid + '/date')
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == null) {
        _showDatePicker(context);
      }
    });
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _needs.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          _needs[index].toString(),
          //_needs[index]['Name'].toString(),
        );
      },
    );
  }
}
