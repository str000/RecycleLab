import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final ref = FirebaseDatabase.instance.reference();
  final _allCategories = [];
  final List _needs = [];
  List _category = [];
  final List<String> _selectedItems = [];
  final List<String> _toolsNames = [];

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

  void _onSearchItems(String searchValue) {
    if (searchValue.length >= 3) {
      final filter = [];
      for (int x = 0; x < _allCategories.length; x++) {
        if (_allCategories[x].contains(searchValue)) {
          filter.add(_allCategories[x]);
        }
      }
      setState(() {
        _category = filter;
      });
    } else {
      setState(() {
        _category = [];
      });
    }
  }

  void _addItem(String itemName) {
    if (_selectedItems.contains(itemName) == false) {
      setState(() {
        _selectedItems.add(itemName);
      });
    }
  }

  void _removeItem(String itemName) {
    setState(() {
      _selectedItems.removeWhere((item) => item == itemName);
    });
  }

  void _addTool(String toolName) {
    if (toolName != '') {
      if (_toolsNames.contains(toolName) == false) {
        setState(() {
          _toolsNames.add(toolName);
        });
        //_searchTextController.text = '';
      }
    }
  }

  void _removeTool(String toolName) {
    setState(() {
      _toolsNames.removeWhere((item) => item == toolName);
    });
  }

  @override
  void initState() {
    super.initState();
    ref.child('category').once().then((event) async {
      var values = event.value;
      setState(() {
        _needs.add(values);
      });

      final allElements = values.values;

      for (final element in allElements) {
        setState(() {
          _allCategories.addAll(element.where((item) => item != null));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: IndexedStack(
            children: <Widget>[
              ChooseItems(
                allCategories: _allCategories,
                searchValue: _onSearchItems,
                addItem: _addItem,
                removeItem: _removeItem,
                selectedItems: _selectedItems,
                category: _category,
              ),
              ChooseTools(
                toolsNames: _toolsNames,
                addTool: _addTool,
                removeTool: _removeTool,
              ),
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
      ),
    );
  }
}
