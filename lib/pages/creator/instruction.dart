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
  List<String> _steps = [];
  var _numbersOfSteps = 2;
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 0, right: 20, top: 20, left: 20),
          child: Column(
            children: const [
              Align(
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
            ],
          ),
        ),
      ),
    );
  }
}
