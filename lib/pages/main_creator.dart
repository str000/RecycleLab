import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';

import 'creator/title_page.dart';
import 'creator/choose_items.dart';
import 'creator/choose_tools.dart';
import 'creator/instruction.dart';

class MainCreator extends StatefulWidget {
  const MainCreator({Key? key}) : super(key: key);

  @override
  _MainCreator createState() => _MainCreator();
}

class _MainCreator extends State<MainCreator> {
  var currentIndex = 0;

  String title = ' ';
  String desc = ' ';
  List<String> items = [];
  List<String> tools = [];
  List<String> steps = [];
  bool public = false;

  callback(title, desc) {
    setState(() {
      title = ' ';
      desc = ' ';
      items = [];
      tools = [];
      public = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: IndexedStack(
          children: const <Widget>[
            ChooseItems(),
            ChooseTools(),
            Intruction(),
            TitlePage(),
          ],
          index: currentIndex,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentIndex == 0
                      ? const SizedBox()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 30.0,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              currentIndex--;
                            });
                          },
                          child: const Text(
                            "Wróć",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 30.0,
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (currentIndex < 3) {
                            currentIndex++;
                          }
                        },
                      );
                    },
                    child: Text(
                      currentIndex == 3 ? "Zakończ" : "Dalej",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
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
