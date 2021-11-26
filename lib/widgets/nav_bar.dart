//Plugins
import 'package:flutter/material.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
//Pages
import 'package:auth/pages/accessibility_page.dart';
import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/liked_page.dart';
//Theme
import 'package:auth/theme/colors.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, .15),
          blurRadius: 30,
          offset: Offset(0, 0),
        )
      ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.accessibility,
                  size: 40,
                  color: halfBlackColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AccessibilityPage(),
                    ),
                  );
                },
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.home,
                  size: 40,
                  color: primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(user: FirebaseAuth.instance.currentUser),
                    ),
                  );
                },
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.favorite,
                  size: 40,
                  color: halfBlackColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LikedPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                child: Container(
                  width: 60.0,
                  height: 5.0,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
