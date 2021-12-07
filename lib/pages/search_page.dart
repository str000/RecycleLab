//Plugins
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusSearch.unfocus();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  controller: _searchTextController,
                  focusNode: _focusSearch,
                  style: signTextFormField,
                  decoration: CommonStyle.textFieldStyle(
                    labelTextStr: "Wyszukaj",
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
          ],
        ),
      ),
    );
  }
}
