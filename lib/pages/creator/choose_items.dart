import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:flutter/material.dart';

class ChooseItems extends StatefulWidget {
  const ChooseItems({Key? key}) : super(key: key);

  @override
  _ChooseItems createState() => _ChooseItems();
}

class _ChooseItems extends State<ChooseItems> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 20, right: 20, top: 20, left: 20),
                    child: Text(
                      'Wybierz przedmioty',
                      style: documentsText,
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      style: signTextFormField,
                      controller: myController,
                      decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "np. butelka",
                      ),
                      onChanged: (String? value) {
                        setState(() {});
                      },
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
