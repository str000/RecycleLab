//Plugins
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusSearch.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: Column(
              children: [
                Stack(
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralWidgets.category(
                      categoryName: "Pojemniki",
                      icon: Icons.liquor_rounded,
                      onClick: () {},
                      context: context,
                    ),
                    GeneralWidgets.category(
                      categoryName: "Materiały Budowlane",
                      icon: Icons.construction_rounded,
                      onClick: () {},
                      context: context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralWidgets.category(
                      categoryName: "Elektronika",
                      icon: Icons.electrical_services_rounded,
                      onClick: () {},
                      context: context,
                    ),
                    GeneralWidgets.category(
                      categoryName: "Guma",
                      icon: Icons.waves_rounded,
                      onClick: () {},
                      context: context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralWidgets.category(
                      categoryName: "Środki Czystości",
                      icon: Icons.clean_hands_rounded,
                      onClick: () {},
                      context: context,
                    ),
                    GeneralWidgets.category(
                      categoryName: "Meble",
                      icon: Icons.chair_rounded,
                      onClick: () {},
                      context: context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralWidgets.category(
                      categoryName: "Artykuły Biurowe",
                      icon: Icons.edit_rounded,
                      onClick: () {},
                      context: context,
                    ),
                    GeneralWidgets.category(
                      categoryName: "Kosmetyki",
                      icon: Icons.sanitizer_rounded,
                      onClick: () {},
                      context: context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(236, 236, 236, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.more_horiz,
                                  size: 35,
                                  color: halfBlackColor,
                                ),
                                Text(
                                  'Inne',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w800,
                                    color: halfBlackColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
