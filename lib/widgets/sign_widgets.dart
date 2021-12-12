//Plugins
import 'package:flutter/material.dart';
//Theme
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';

class CommonStyle {
  static InputDecoration textFieldStyle({
    String labelTextStr = "",
    String hintTextStr = "",
    final suffIcon,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 30.0, right: 20.0),
      labelText: labelTextStr,
      labelStyle: signTextFormField,
      hintText: hintTextStr,
      hintStyle: signTextFormFieldHint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: quarterBlackcolor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      errorStyle: const TextStyle(
        height: 0,
        fontSize: 0.0,
      ),
      suffixIcon: suffIcon,
    );
  }
}
