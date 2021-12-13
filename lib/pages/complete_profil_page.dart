//Plugins
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:image_picker/image_picker.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Pages
import 'package:auth/pages/main_page.dart';
//Utils
//Theme
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
//Widgets
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/sign_widgets.dart';

class CompleteProfilPage extends StatefulWidget {
  const CompleteProfilPage({Key? key}) : super(key: key);

  @override
  _CompleteProfilPageState createState() => _CompleteProfilPageState();
}

class _CompleteProfilPageState extends State<CompleteProfilPage> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseDatabase.instance.reference();

  final _nameTextController = TextEditingController();
  final _nameIDTextController = TextEditingController();
  final _focusName = FocusNode();
  final _focusNameID = FocusNode();

  var _image;
  var imagePicker;
  bool _isButtonDisabled = true;

  bool _isFreeNameID = false;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  Future<void> uploadFile() async {
    await FirebaseStorage.instance
        .ref('users/' + _currentUser!.uid + '/profile-photo.png')
        .putFile(_image);
  }

  checkNameID(String? valueT) async {
    var nameIDArray = [];
    await ref.child('users').once().then((value) {
      final values = value.value.values;
      for (final element in values) {
        nameIDArray.add(element['nameID']);
      }
      if (nameIDArray.contains(valueT) != true &&
          _nameIDTextController.text.length >= 6) {
        setState(() {
          _isFreeNameID = true;
        });
        validate();
      } else {
        setState(() {
          _isFreeNameID = false;
        });
      }
    });
  }

  validate() {
    if (_nameTextController.text.isNotEmpty &&
        _nameIDTextController.text.isNotEmpty &&
        _image != null) {
      if (_isFreeNameID == true && _nameIDTextController.text.length >= 6) {
        setState(() {
          _isButtonDisabled = false;
        });
      } else {
        setState(() {
          _isButtonDisabled = true;
        });
      }
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusNameID.unfocus();
      },
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            elevation: 6.0,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Naciśnij ponownie aby opuścić',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Nunito',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appName,
                        style: appNameSign,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Uzupełnij Profil',
                        style: pageNameSign,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: contrastWhite,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: _image != null
                              ? Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Image.file(
                                      _image,
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: GeneralWidgets.actionButton(
                                        backgroundColor: quarterBlackcolor,
                                        icon: const Icon(
                                          Icons.image_rounded,
                                          color: Colors.black,
                                          size: 35,
                                        ),
                                        onClick: () {},
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.image_rounded,
                                      color: halfBlackColor,
                                      size: 100,
                                    ),
                                    Text(
                                      'Wybierz zdjęcie profilowe',
                                      style: postTitleStyle,
                                    )
                                  ],
                                ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                XFile image = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  _image = File(image.path);
                                });
                                validate;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13.0),
                  TextFormField(
                    controller: _nameTextController,
                    focusNode: _focusName,
                    style: signTextFormField,
                    decoration: CommonStyle.textFieldStyle(
                      labelTextStr: "Nazwa",
                    ),
                    onChanged: validate(),
                  ),
                  const SizedBox(height: 13.0),
                  TextFormField(
                    controller: _nameIDTextController,
                    focusNode: _focusNameID,
                    style: signTextFormField,
                    decoration: CommonStyle.textFieldStyle(
                        labelTextStr: "Unikalna nazwa konta",
                        suffIcon: Icon(
                          Icons.done_rounded,
                          color: _isFreeNameID
                              ? const Color.fromRGBO(1, 124, 13, 1)
                              : quarterBlackcolor,
                          size: 24,
                        )),
                    onChanged: (v) {
                      checkNameID(v);
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'co najmniej 6 znaków',
                    style: postSmallName,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : () async {
                          await uploadFile();
                          ref.child('users/' + _currentUser!.uid).set({
                            'nameID': _nameIDTextController.text,
                            'name': _nameTextController.text,
                          });
                          _currentUser
                              ?.updateDisplayName(_nameTextController.text);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainPage(
                                user: _currentUser,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Zapisz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
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
