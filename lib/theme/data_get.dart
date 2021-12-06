//Plugins
import 'package:auth/pages/settings/disabilities_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/theme/text.dart';
//Theme
import 'package:auth/theme/colors.dart';

final ref = FirebaseDatabase.instance.reference();
final User? _currentUser = FirebaseAuth.instance.currentUser;

double get(){
  double dataValue =(ref.child('users/' + _currentUser!.uid + '/fontSize').onValue.listen((event) {var data = event.snapshot;})) as double;

    if(dataValue != null){
      return(dataValue);
    }
    else {
      return(22);
    }
}