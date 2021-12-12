import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChooseItems extends StatefulWidget {
  const ChooseItems({Key? key}) : super(key: key);

  @override
  _ChooseItems createState() => _ChooseItems();
}

class _ChooseItems extends State<ChooseItems> {
  final myController = TextEditingController();
  final _focusSearch = FocusNode();
  final ref = FirebaseDatabase.instance.reference();
  final _categories = [];
  final filter = [];
  final _allCategories = [];
  final List _needs = [];

  var _index = 0;
  var categoryCurr = '';
  var _result = 0;

  List<String> selectedItems = []; //!!! finalna lista
  List _category = [];

  String itemName = ' ';
  String _categoryName = '';
  String? providedNeedName;

  bool _isCategory = false;

  add(String name) {
    selectedItems.add(name);
  }

  del(int index) {
    selectedItems.removeAt(index);
  }

  @override
  void initState() {
    super.initState();
    ref.child('category').once().then((event) async {
      var values = event.value;
      setState(() {
        _needs.add(values);
        _category = values['elektronika'];
        _categoryName = ' ';
        _index = 0;
        _result = 0;
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 0, right: 20, top: 0, left: 20),
          child: Column(
            children: [
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 20, right: 20, top: 20, left: 20),
                      child: Text(
                        'Wybierz przedmioty',
                        style: documentsText,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                          style: signTextFormField,
                          focusNode: _focusSearch,
                          controller: myController,
                          decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "np. butelka",
                          ),
                          onChanged: (String? value) async {
                            if (_index == 0) {
                              setState(() {
                                _isCategory = false;
                              });
                            }

                            if (_isCategory == false) {
                              if (value!.length >= 3) {
                                final filter = [];
                                for (int x = 0;
                                    x < _allCategories.length;
                                    x++) {
                                  if (_allCategories[x].contains(value)) {
                                    filter.add(_allCategories[x]);
                                  }
                                }
                                setState(() {
                                  _category = filter;
                                  _categoryName = 'Wyniki';
                                  _index = 1;
                                });
                              } else {
                                setState(() {
                                  _index = 0;
                                });
                              }
                            } else {
                              if (value!.length >= 3) {
                                for (int x = 0; x < _category.length; x++) {
                                  if (_category[x].contains(value)) {
                                    filter.add(_category[x]);
                                  }
                                }
                                setState(() {
                                  _category = filter;
                                });
                              } else {
                                setState(() {
                                  _category = _categories[0][_categoryName];
                                });
                              }
                            }
                          }),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _category.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(236, 236, 236, 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          "${_category[index].toString()[0].toUpperCase()}${_category[index].toString().substring(1)}",
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w800,
                                            color: halfBlackColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          itemName =
                                              "${_category[index].toString()[0].toUpperCase()}${_category[index].toString().substring(1)}";
                                          add(itemName);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Divider(),
              const Text(
                'Wybrane przedmioty',
                style: documentsText,
              ),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectedItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(0, 181, 255, 1.0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          "${selectedItems[index].toString()[0].toUpperCase()}${selectedItems[index].toString().substring(1)}",
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w800,
                                            color: halfBlackColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          itemName =
                                          "${_category[index].toString()[0].toUpperCase()}${_category[index].toString().substring(1)}";
                                          del(index);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
