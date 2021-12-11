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
  List<String> toolsNames = [];
  String? toolName = ' ';

  add(String name) {
    toolsNames.add(name);
  }

  del(int index) {
    toolsNames.removeAt(index);
  }

  @override
  void initState() {
    super.initState();
    setState((){
      toolsNames;
      toolName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
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
                          'Wprowadź narzędzia',
                          style: documentsText,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          style: signTextFormField,
                          decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "np. nożyczki",
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              toolName = value;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (toolName != null) {
                                  add(toolName!);
                                }
                                print(toolsNames[0]);
                              });
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
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(236, 236, 236, 1),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
