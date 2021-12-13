import 'dart:io';

import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'creator/title_page.dart';
import 'creator/choose_items.dart';
import 'creator/choose_tools.dart';
import 'creator/instruction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MainCreator extends StatefulWidget {
  const MainCreator({Key? key}) : super(key: key);

  @override
  _MainCreator createState() => _MainCreator();
}

class _MainCreator extends State<MainCreator> {
  User? _currentUser = FirebaseAuth.instance.currentUser;
  var postID;
  final ref = FirebaseDatabase.instance.reference();
  final _allCategories = [];
  final List _needs = [];
  List _category = [];
  final List<String> _selectedItems = [];
  final List<String> _toolsNames = [];
  final List _stepsList = [];
  final List<File> _stepsImg = [];
  final List _stepsImgURL = [];
  int _currentStepValue = 0;
  var _imagePicker;
  String _title = ' ';
  String _desc = ' ';
  bool _private = false;

  var currentIndex = 0;

  String title = ' ';
  String desc = ' ';
  List<String> items = [];
  List<String> tools = [];
  List<String> steps = [];
  bool public = false;

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
      }
    }
  }

  void _removeTool(String toolName) {
    setState(() {
      _toolsNames.removeWhere((item) => item == toolName);
    });
  }

  void _add(String name, int index) {
    if (_stepsList.isEmpty) {
      _stepsList.insert(index, name);
    } else {
      _stepsList[index] = name;
    }
  }

  void _addImg(File name, int index) {
    if (_stepsImg.isEmpty) {
      setState(() {
        _stepsImg.insert(index, name);
      });
    } else {
      setState(() {
        _stepsImg[index] = name;
      });
    }
  }

  void _onChangedStep(String value, int index) {
    if (index == _currentStepValue) {
      setState(() {
        _currentStepValue++;
        _stepsList.length = _currentStepValue;
      });
    }

    if (value == '' && index == _currentStepValue - 1) {
      _stepsImg.removeWhere((item) => item == _stepsImg[_currentStepValue]);
      _stepsImg.length = 30;
    }

    if (value == '') {
      setState(() {
        _currentStepValue--;
      });
    } else {}

    if (value == '' && index == _currentStepValue - 1) {
      setState(() {
        _stepsList.length = _currentStepValue;
      });
    }

    setState(() {
      _add(value, index);
    });
  }

  void _onTitleChange(String value) {
    setState(() {
      _title = value;
    });
  }

  void _onDescChange(String value) {
    setState(() {
      _desc = value;
    });
  }

  void _onStatusChange(bool value) {
    setState(() {
      _private = value;
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
    _stepsImg.length = 30;
    _imagePicker = ImagePicker();
    _currentStepValue = 0;
  }

  Future<void> uploadFile(var index, File _image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child('posts/' + postID + '/photo' + index.toString());
    ref.putFile(_image);
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
              Intruction(
                stepsList: _stepsList,
                stepsImg: _stepsImg,
                currentStepValue: _currentStepValue,
                imagePicker: _imagePicker,
                add: _add,
                addImg: _addImg,
                onChangedStep: _onChangedStep,
              ),
              TitlePage(
                title: _title,
                desc: _desc,
                private: _private,
                onTitleChange: _onTitleChange,
                onDescChange: _onDescChange,
                onStatusChange: _onStatusChange,
              ),
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
                        if (currentIndex == 0) {
                          if (postID == null) {
                            var id = ref.child('posts').push().key;
                            setState(() {
                              postID = id;
                            });
                          }
                          ref.child('posts/' + postID).set({
                            'authorID': _currentUser!.uid,
                          });
                          ref.child('posts/' + postID + '/categories').set(
                                _selectedItems,
                              );
                        } else if (currentIndex == 1) {
                          ref.child('posts/' + postID + '/items').set(
                                _toolsNames,
                              );
                        } else if (currentIndex == 2) {
                          setState(() {
                            _stepsImgURL.length = _currentStepValue;
                          });
                          ref
                              .child('posts/' + postID + '/postStructure/texts')
                              .set(
                                _stepsList,
                              );
                          for (int x = 0; x < _currentStepValue; x++) {
                            uploadFile(x, _stepsImg[x]);
                          }
                        } else {}

                        if (currentIndex < 3) {
                          setState(() {
                            currentIndex++;
                          });
                        }
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
