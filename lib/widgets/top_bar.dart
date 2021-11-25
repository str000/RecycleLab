import 'package:auth/pages/settings_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const TopBar({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 90,
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 20.0,
              right: 10.0,
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(appName,
                      style: const TextStyle(
                        fontSize: 35.0,
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      )),
                  Row(children: <Widget>[
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.notifications_none,
                          size: 35,
                          color: Color.fromRGBO(0, 0, 0, .5),
                        ),
                        onPressed: () {}),
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.settings,
                          size: 35,
                          color: Color.fromRGBO(0, 0, 0, .5),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        }),
                  ])
                ])),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
