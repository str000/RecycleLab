//Plugins
import 'package:auth/pages/search/categories_page.dart';
import 'package:auth/pages/search/subcategories_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/sign_widgets.dart';
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

  var _index = 0;

  String _category = '';

  void _updateCategory(String count) {
    setState(() {
      _category = count;
      _index = 1;
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
                      onChanged: (String? value) {},
                    ),
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
                            "${_category[0].toUpperCase()}${_category.substring(1)}",
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
