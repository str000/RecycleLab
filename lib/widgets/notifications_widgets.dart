//Plugins
import 'package:flutter/material.dart';
//Theme
import 'package:auth/theme/colors.dart';

class NotificationsWidgets {
  static Wrap notification({
    String notificationTitle = "",
    String notificationContent = "",
    bool isButton = false,
    String notificationButton = "",
    final onPress,
  }) {
    return Wrap(
      runSpacing: 10.0,
      children: [
        Text(
          notificationTitle,
          style: const TextStyle(
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          notificationContent,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: isButton
                    ? ElevatedButton(
                        onPressed: onPress,
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                        ),
                        child: Text(
                          notificationButton,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
