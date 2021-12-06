//Plugins
import 'package:auth/pages/settings/disabilities_page.dart';
import 'package:flutter/material.dart';
//Theme
import 'package:auth/theme/colors.dart';

String appName = "Nazwa Apki";

var fontSize;
late List<bool> isSelected;

void initState() {
  isSelected = [
    false,
    true,
    false,
  ];
}

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
  fontSize: fontSize,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);
