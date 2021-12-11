import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Intruction extends StatefulWidget {
  const Intruction({Key? key}) : super(key: key);

  @override
  _Intruction createState() => _Intruction();
}

class _Intruction extends State<Intruction> {
  final List<String> _steps = [];
  final _numbersOfSteps = 1;
  var currentIndex = 0;

  add(String name) {
    _steps.add(name);
  }

  del(int index) {
    _steps.removeAt(index);
  }

  @override
  void initState() {
    super.initState();
     setState((){
       _steps;
       _numbersOfSteps;
       currentIndex;
     });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 0, right: 20, top: 20, left: 20),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 20, right: 20, top: 0, left: 20),
                  child: Text(
                    'Stwórz instrukcje',
                    style: documentsText,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _numbersOfSteps,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(236, 236, 236, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  style: signTextFormField,
                                  decoration: CommonStyle.textFieldStyle(
                                    labelTextStr: "Krok ${index + 1}",
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
