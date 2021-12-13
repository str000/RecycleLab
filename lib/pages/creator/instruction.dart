import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Intruction extends StatelessWidget {
  final List stepsList;
  final List<File> stepsImg;
  int currentStepValue;
  var imagePicker;
  final Function add;
  final Function addImg;
  final Function onChangedStep;
  Intruction({
    Key? key,
    required this.stepsList,
    required this.stepsImg,
    required this.currentStepValue,
    required this.imagePicker,
    required this.add,
    required this.addImg,
    required this.onChangedStep,
  }) : super(key: key);

  /*add(String name, int index) {
    if (stepsList.isEmpty) {
      stepsList.insert(index, name);
    } else {
      stepsList[index] = name;
    }
  }

  addImg(File name, int index) async {
    if (stepsImg.isEmpty) {
      setState(() {
        stepsImg.insert(index, name);
      });
    } else {
      setState(() {
        stepsImg[index] = name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    stepsImg.length = 30;
    imagePicker = ImagePicker();
    currentStepValue = 0;
  }
*/
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Stwórz Instrukcje',
                      style: newPostStepName,
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: currentStepValue + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GeneralWidgets.stepEditor(
                        context: context,
                        image: stepsImg[index],
                        photoClick: () async {
                          XFile image = await imagePicker.pickImage(
                              source: ImageSource.gallery);

                          await addImg(File(image.path), index);
                        },
                        stepNumber: 'Krok ${index + 1}',
                        stepColor: Colors.black,
                        onChanged: (String value) {
                          //stepsList[0] = value;
                          onChangedStep(value, index);
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
