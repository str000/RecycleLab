import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChooseItems extends StatelessWidget {
  List allCategories;
  List category;
  List<String> selectedItems;
  final Function searchValue;
  final Function addItem;
  final Function removeItem;
  final myControllerItems;
  ChooseItems(
      {Key? key,
      required this.allCategories,
      required this.searchValue,
      required this.addItem,
      required this.removeItem,
      required this.selectedItems,
      required this.category,
      required this.myControllerItems,})
      : super(key: key);

  final _focusSearch = FocusNode();

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
                controller: myControllerItems,
                decoration: CommonStyle.textFieldStyle(
                  labelTextStr: "Wyszukaj przedmiotu",
                ),
                onChanged: (String v) => searchValue(v),
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
                        itemCount: category.length,
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
                                            "${category[index].toString()[0].toUpperCase()}${category[index].toString().substring(1)}",
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
                                          addItem(category[index].toString());
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
                                          removeItem(
                                              category[index].toString());
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
