import 'package:auth/theme/text.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({Key? key}) : super(key: key);

  @override
  _TitlePage createState() => _TitlePage();
}

class _TitlePage extends State<TitlePage> {
  bool _private = false; //!!! finalny status postu

  String _title = ' '; //!!! finalny tytuł
  String _desc = ' '; //!!! finalny opis

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'Uzupełnij Informacje',
                    style: newPostStepName,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, right: 20, top: 0, left: 20),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      style: signTextFormField,
                      decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "np. Karmnik dla ptaków z butelek",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _title = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, right: 20, top: 0, left: 20),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      style: signTextFormField,
                      decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "Opis",
                        
                      ),
                      maxLines: 15,
                      minLines: 10,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(500),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          _desc = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, right: 20, top: 0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text(
                          'Ustaw post publiczny',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CupertinoSwitch(
                          value: _private,
                          onChanged: (value) {
                            setState(() {
                              _private = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
