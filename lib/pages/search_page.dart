//Plugins
import 'package:auth/pages/search/categories_page.dart';
import 'package:auth/pages/search/subcategories_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchTextController = TextEditingController();
  final _focusSearch = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ref = FirebaseDatabase.instance.reference();
  var _index = 0;

  List _category = [];
  final _categories = [];
  final _allCategories = [];
  String _categoryName = '';
  bool _isCategory = false;

  void _updateCategory(String categoryName) {
    setState(() {
      _category = _categories[0][categoryName];
      _categoryName = categoryName;
      _isCategory = true;
      _index = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.child('category').once().then((event) {
      var values = event.value;
      setState(() {
        _categories.add(values);
        _category = values['guma'];
        _categoryName = ' ';
        _index = 0;
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
        _focusSearch.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                        controller: _searchTextController,
                        focusNode: _focusSearch,
                        style: signTextFormField,
                        decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Wyszukaj przedmiotu",
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
                              for (int x = 0; x < _allCategories.length; x++) {
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
                              final filter = [];
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
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          print("Głosowo");
                        },
                        icon: const Icon(Icons.mic),
                        color: halfBlackColor,
                        iconSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              if (_index == 1)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 35,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _index = 0;
                              });
                            },
                          ),
                          Text(
                            "${_categoryName[0].toUpperCase()}${_categoryName.substring(1)}",
                            style: documentsText,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      GeneralWidgets.line(),
                    ],
                  ),
                ),
              Expanded(
                child: IndexedStack(
                  children: <Widget>[
                    CategoriesPage(category: _updateCategory),
                    SubCategoriesPage(category: _category),
                  ],
                  index: _index,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
