//Plugins
import 'package:auth/theme/colors.dart';
import 'package:auth/widgets/sign_widgets.dart';
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

  final _test = TextEditingController();
  final _focusTest = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusTest.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
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
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 120,
            child: Column(
              children: [
                TextFormField(
                  controller: _test,
                  focusNode: _focusTest,
                  style: signTextFormField,
                  decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Nazwa",
                  ),
                  onChanged: (String? value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_test.text.isEmpty) {
                            print("Pusto");
                          } else {
                            print(_test.text);
                            ref.child('posts').push().set({
                              'Name': _test.text,
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text(
                          'Dodaj',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
