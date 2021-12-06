//Plugins
import 'package:auth/pages/settings/disabilities_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Theme
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/data_get.dart';

String appName = "Nazwa Apki";

//--------------------------------------------
//do przeniesienia

var fontSize;

List<bool> isSelected = [false, true, false];

void initState() {isSelected = [false, true, false];}

var fontSizeValue = get();

//-------------------------------------------

const appNameSign = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.w800,
  color: primaryColor,
);

const pageNameSign = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w800,
  color: halfBlackColor,
);

const signTextFormField = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 20.0,
  color: halfBlackColor,
);

const signTextFormFieldHint = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 20.0,
  color: quarterBlackcolor,
);

TextStyle documentsText = TextStyle(
  fontSize: fontSizeValue,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);
