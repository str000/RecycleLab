//Plugins
import 'package:flutter/material.dart';
//Theme
import 'package:auth/theme/colors.dart';

class SettingsWidgets {
  static Row settingOption({
    String optionText = "",
    String optionAction = "",
    final onPress,
    final context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              optionText,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Nunito",
                ),
                primary: halfBlackColor,
              ),
              onPressed: onPress,
              child: Text(optionAction),
            ),
          ],
        ),
      ],
    );
  }
}
