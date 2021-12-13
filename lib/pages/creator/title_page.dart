import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/sign_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitlePage extends StatelessWidget {
  String title;
  String desc;
  bool private;
  Function onTitleChange;
  Function onDescChange;
  Function onStatusChange;
  final myControllerDesc;
  final myControllerTitle;
  TitlePage({
    Key? key,
    required this.title,
    required this.desc,
    required this.private,
    required this.onTitleChange,
    required this.onDescChange,
    required this.onStatusChange,
    required this.myControllerDesc,
    required this.myControllerTitle,
  }) : super(key: key);

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
              TextFormField(
                style: signTextFormField,
                controller: myControllerTitle,
                decoration: CommonStyle.textFieldStyle(
                  labelTextStr: "Tytuł Instrukcji",
                ),
                onChanged: (String v) => onTitleChange(v),
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: signTextFormField,
                controller: myControllerDesc,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.all(20),
                  labelText: 'Opis',
                  labelStyle: signTextFormField,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: quarterBlackcolor,
                    ),
                  ),
                ),
                maxLines: 8,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500),
                ],
                onChanged: (String v) => onDescChange(v),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ustaw post publiczny',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: halfBlackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CupertinoSwitch(
                    value: private,
                    onChanged: (v) => onStatusChange(v),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
