import 'package:auth/theme/text.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:flutter/material.dart';

class ChooseTools extends StatefulWidget {
  const ChooseTools({Key? key}) : super(key: key);

  @override
  _ChooseTools createState() => _ChooseTools();
}

class _ChooseTools extends State<ChooseTools>{

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
                          'Wybierz narzędzia',
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
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}