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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20, top: 20, left: 20),
            child: Column(
              children: [
                const Text(
                  'Poduszka z folii',
                  style: documentsText,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      style: signTextFormField,
                      decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "np. butelka",
                      ),
                      onChanged: (String? value) {},
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
