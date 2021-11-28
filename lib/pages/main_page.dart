//Plugins
import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
//Pages
import 'package:auth/pages/accessibility_page.dart';
import 'package:auth/pages/liked_page.dart';
import 'package:auth/pages/home_page.dart';
//Theme
import 'package:auth/theme/colors.dart';
//Widgets
import 'package:auth/widgets/top_bar.dart';

class MainPage extends StatefulWidget {
  final User? user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var currentIndex = 1;
  final List<Widget> _widgetOptions = [
    const AccessibilityPage(),
    const HomePage(),
    const LikedPage(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const TopBar(
        height: 90,
      ),
      body: DoubleBackToCloseApp(
        child: _widgetOptions.elementAt(currentIndex),
        snackBar: const SnackBar(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Naciśnij ponownie aby opuścić',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Nunito',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 53,
        padding: const EdgeInsets.only(top: 5),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .15),
            blurRadius: 30,
            offset: Offset(0, 0),
          )
        ]),
        child: Center(
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    listOfIcons[index],
                    size: 40,
                    color:
                        index == currentIndex ? primaryColor : halfBlackColor,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? 5 : 0,
                    width: 60,
                    margin: EdgeInsets.only(
                      bottom: 0,
                      right: size.width * 0.05,
                      left: size.width * 0.05,
                    ),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.accessibility,
    Icons.home,
    Icons.favorite,
  ];
}
