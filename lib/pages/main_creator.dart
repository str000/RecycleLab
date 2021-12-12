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

  callback(title,desc) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              children: [
                GeneralWidgets.line(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: currentIndex <= 0 ? 0.5 : 1.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 22,
                            color:
                                currentIndex <= 0 ? Colors.grey : Colors.blue,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Nunito",
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (currentIndex <= 0) {
                                currentIndex = 0;
                              } else {
                                currentIndex--;
                              }
                            },
                          );
                        },
                        child: const Text("Wróć"),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            if (currentIndex >= 3) {
                              currentIndex = 3;
                              print("wysłano do bazy");
                            } else {
                              currentIndex++;
                            }
                          },
                        );
                      },
                      child: Text(currentIndex >= 3 ? "Zakończ!" : "Dalej"),
                    ),
                  ],
                ),
                GeneralWidgets.line(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 216,
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
        ],
      ),
    );
  }
}
