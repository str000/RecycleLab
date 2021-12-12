import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:flutter/material.dart';

class ChooseTools extends StatefulWidget {
  const ChooseTools({Key? key}) : super(key: key);

  @override
  _ChooseTools createState() => _ChooseTools();
}

class _ChooseTools extends State<ChooseTools> {
  List<String> toolsNames = []; //!!! finalna lista
  String? toolName = ' ';
  final _searchTextController = TextEditingController();
  final _focusSearch = FocusNode();

  add(String name) {
    if (name != '') {
      if (toolsNames.contains(name) == false) {
        toolsNames.add(name);
        _searchTextController.text = '';
      }
    }
  }

  del(String index) {
    toolsNames.removeWhere((item) => item == index);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      toolsNames;
      toolName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusSearch.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Wybierz Narzędzia',
                          style: newPostStepName,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          controller: _searchTextController,
                          focusNode: _focusSearch,
                          style: signTextFormField,
                          decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Nazwa narzędzia",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                add(_searchTextController.text);
                              });
                            },
                            icon: const Icon(Icons.add_rounded),
                            color: halfBlackColor,
                            iconSize: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                    toolsNames.isEmpty
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
                  itemCount: toolsNames.length,
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
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          "${toolsNames[index].toString()[0].toUpperCase()}${toolsNames[index].toString().substring(1)}",
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
                                      del(toolsNames[index].toString());
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
      ),
    );
  }
}
