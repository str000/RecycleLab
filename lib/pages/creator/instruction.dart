import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/sign_widgets.dart';
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

  var _image;
  var imagePicker;

  Future<void> uploadFile() async {
    await FirebaseStorage.instance
        .ref('users/' + _currentUser!.uid + '/profile-photo.png')
        .putFile(_image);
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _step1Focus.unfocus();
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
                GeneralWidgets.stepEditor(
                  context: context,
                  image: _image,
                  photoClick: () async {
                    XFile image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    setState(() {
                      _image = File(image.path);
                    });
                  },
                  textControler: _step1TextController,
                  focusController: _step1Focus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
