//Plugins
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colorFilters.dart';
//Firebase Package
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Pages
//Utils
//Theme
//Widgets

bool colorFilterSwitchValue = false;

ColorFilter returnColorFilter(bool colorFilterSwitchValue){

  //tutaj trzeba pobieranie bazy zamiast brania lokanej wartości

  if(colorFilterSwitchValue == true){
    return sepia;
  }else{
    return identity;
  }
}

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {

  final ref = FirebaseDatabase.instance.reference();
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState(){
    colorFilterSwitchValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Ślepota barw',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //------Dostosowania------
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        //Ślepota barw
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Sepia',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CupertinoSwitch(
                                  value: colorFilterSwitchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      colorFilterSwitchValue = value;

                                      if((ref.child('users/' + _currentUser!.uid)) == null){
                                        ref.child('users/' + _currentUser!.uid).push().set({'colorFilterSepia':  value,});
                                      }else {
                                        ref.child('users/' + _currentUser!.uid).update({'colorFilterSepia':  value,});
                                      }

                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 13.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}