//Plugins
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/utils/data_models.dart';
import 'package:auth/utils/validator.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
  final ref = FirebaseDatabase.instance.reference();

  final User? _currentUser = FirebaseAuth.instance.currentUser;

  var retrievedName = {};
  List<Test> companyList = [];

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

  @override
  void initState() {
    ref.onValue.listen((event) {
      var data = event.snapshot;
      setState(() {
        retrievedName = data.value['L1'];
      });
      print(retrievedName);
    });

    super.initState();
    ref
        .child('users/' + _currentUser!.uid + '/date')
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == null) {
        _showDatePicker(context);
      }
    });
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
