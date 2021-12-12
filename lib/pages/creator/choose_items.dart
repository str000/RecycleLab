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
  final filter = [];
  final _allCategories = [];
  final List _needs = [];

  var categoryCurr = '';

  List<String> selectedItems = []; //!!! finalna lista
  List _category = [];

  String itemName = ' ';
  String? providedNeedName;

  add(String name) {
    if (selectedItems.contains(name) == false) {
      selectedItems.add(name);
    }
  }

  del(String index) {
    selectedItems.removeWhere((item) => item == index);
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusSearch.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'Wybierz Przedmioty',
                    style: newPostStepName,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: signTextFormField,
                focusNode: _focusSearch,
                controller: myController,
                decoration: CommonStyle.textFieldStyle(
                  labelTextStr: "Wyszukaj przedmiotu",
                ),
                onChanged: (String? value) async {
                  if (value!.length >= 3) {
                    final filter = [];
                    for (int x = 0; x < _allCategories.length; x++) {
                      if (_allCategories[x].contains(value)) {
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
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      ListView.builder(
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
                                      color: const Color.fromRGBO(
                                          236, 236, 236, 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                _category[index].toString();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 1,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: quarterBlackcolor,
                            ),
                          ),
                          selectedItems.isEmpty
                              ? const Text(
                                  'Wybierz',
                                  style: documentsText,
                                )
                              : const Text(
                                  'Wybrane',
                                  style: documentsText,
                                ),
                          Container(
                            height: 1,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: quarterBlackcolor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
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
                                  Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "${selectedItems[index].toString()[0].toUpperCase()}${selectedItems[index].toString().substring(1)}",
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.clear_rounded,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            itemName =
                                                _category[index].toString();
                                            del(itemName);
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
                    ],
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
