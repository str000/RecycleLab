import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Intruction extends StatefulWidget {
  const Intruction({Key? key}) : super(key: key);

  @override
  _Intruction createState() => _Intruction();
}

class _Intruction extends State<Intruction> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final _step1TextController = TextEditingController();
  final _step1Focus = FocusNode();

  List _stepsList = [];
  List<File> _stepsImg = [];

  var _image;
  int currentStepValue = 0;
  var imagePicker;

  Future<void> uploadFile() async {
    await FirebaseStorage.instance
        .ref('users/' + _currentUser!.uid + '/profile-photo.png')
        .putFile(_image);
  }

  add(String name, int index) {
    if (_stepsList.isEmpty) {
      _stepsList.insert(index, name);
    } else {
      _stepsList[index] = name;
    }
  }

  addImg(File name, int index) async {
    if (_stepsImg.isEmpty) {
      setState(() {
        _stepsImg.insert(index, name);
      });
    } else {
      setState(() {
        _stepsImg[index] = name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _stepsImg.length = 30;
    imagePicker = ImagePicker();
    currentStepValue = 0;
  }

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
                        image: _stepsImg[index],
                        photoClick: () async {

                          XFile image = await imagePicker.pickImage(
                              source: ImageSource.gallery);

                          await addImg(File(image.path), index);

                        },
                        stepNumber: 'Krok ${index + 1}',
                        stepColor: Colors.black,
                        onChanged: (String value) {
                          //_stepsList[0] = value;
                          if (index == currentStepValue) {
                            setState(() {
                              currentStepValue++;
                              _stepsList.length = currentStepValue;
                              //_stepsImg.length = currentStepValue;
                            });
                          }

                          if (value == '') {
                            setState(() {
                              currentStepValue--;
                            });
                          } else {}

                          if (value == '' && index == currentStepValue - 1) {
                            setState(() {
                              _stepsList.length = currentStepValue;
                              //_stepsImg.length = currentStepValue;
                            });
                          }

                          setState(() {
                            add(value, index);
                          });

                          print(_stepsList);
                          print(_stepsImg);
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
