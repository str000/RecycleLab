//Plugins
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//Firebase Package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
//Utils
import 'package:auth/utils/fire_auth.dart';
import 'package:auth/utils/validator.dart';
//Theme
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
//Widgets
import 'package:auth/widgets/sign_widgets.dart';
import 'package:auth/widgets/general_widgets.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final ref = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameTextController = TextEditingController();
  final _nameIDTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusNameID = FocusNode();
  final _focusEmail = FocusNode();
  String name = '';
  var _image;
  var imagePicker;
  var profileImageURL;

  User? _currentUser = FirebaseAuth.instance.currentUser;

  bool _isgoogle = false;

  bool _ischanged = false;

  changed() {
    if (_nameTextController.text != _currentUser?.displayName ||
        _image != null) {
      setState(() {
        _ischanged = true;
      });
    } else {
      setState(() {
        _ischanged = false;
      });
    }
  }

  Future<void> uploadFile() async {
    await FirebaseStorage.instance
        .ref('users/' + _currentUser!.uid + '/profile-photo.png')
        .putFile(_image);
  }

  Future<void> downloadProfilePhoto() async {
    final ref = FirebaseStorage.instance
        .ref('users/' + _currentUser!.uid + '/profile-photo.png');
    var url = await ref.getDownloadURL();
    setState(() {
      profileImageURL = url;
    });
  }

  @override
  void initState() {
    imagePicker = ImagePicker();
    _image = null;
    profileImageURL = null;
    _ischanged = false;
    _focusName.unfocus();
    downloadProfilePhoto();

    _nameTextController.text = _currentUser!.displayName!;
    ref.child('users/' + _currentUser!.uid + '/nameID').once().then((value) {
      _nameIDTextController.text = '@' + value.value;
      name = value.value;
    });

    _emailTextController.text = _currentUser!.email!;
    if (_currentUser!.providerData[0].providerId == "google.com") {
      _isgoogle = true;
    }
    super.initState();
  }

  Future<void> refresh() async {
    User? user = await FireAuth.refreshUser(_currentUser!);

    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
    initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusNameID.unfocus();
        _focusEmail.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      //------Pasek Górny------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 35,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              'Ustawienia',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //------Napis Ustawienia------
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            child: const Text(
                              'Dane Konta',
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                      //------Ustawienia------
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: _isgoogle
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 13.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4),
                                                      topRight:
                                                          Radius.circular(4),
                                                      bottomLeft:
                                                          Radius.circular(4),
                                                      bottomRight:
                                                          Radius.circular(4),
                                                    ),
                                                    border: Border.all(
                                                        color:
                                                            quarterBlackcolor),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 12.0,
                                                      bottom: 12.0,
                                                      left: 20.0,
                                                      right: 20.0,
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      children: [
                                                        const Image(
                                                            width: 26.0,
                                                            height: 26.0,
                                                            image: AssetImage(
                                                                'assets/google_logo.png')),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                              'Konto Google',
                                                              style: TextStyle(
                                                                color:
                                                                    halfBlackColor,
                                                                fontSize: 20.0,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : null,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                            height: 250,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: contrastWhite,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                _image != null
                                                    ? Image.file(
                                                        _image,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : profileImageURL != null
                                                        ? Image.network(
                                                            profileImageURL,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 250,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  CircularProgressIndicator(),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: GeneralWidgets
                                                      .actionButton(
                                                    backgroundColor:
                                                        quarterBlackcolor,
                                                    icon: const Icon(
                                                      Icons.image_rounded,
                                                      color: Colors.black,
                                                      size: 35,
                                                    ),
                                                    onClick: () {},
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Positioned.fill(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () async {
                                                XFile image =
                                                    await imagePicker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  _image = File(image.path);
                                                });
                                                changed();
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
                                    validator: (value) =>
                                        Validator.validateName(
                                      name: value,
                                    ),
                                    style: signTextFormField,
                                    decoration: CommonStyle.textFieldStyle(
                                      labelTextStr: "Nazwa",
                                    ),
                                    onChanged: (String? value) {
                                      _formKey.currentState!.validate();
                                      changed();
                                    },
                                  ),
                                  const SizedBox(height: 13.0),
                                  TextFormField(
                                    controller: _nameIDTextController,
                                    focusNode: _focusNameID,
                                    enabled: false,
                                    style: signTextFormField,
                                    decoration: CommonStyle.textFieldStyle(
                                      labelTextStr: "Unikalna nazwa konta",
                                    ),
                                    onChanged: (String? value) {
                                      _formKey.currentState!.validate();
                                      changed();
                                    },
                                  ),
                                  const SizedBox(height: 13.0),
                                  TextFormField(
                                    controller: _emailTextController,
                                    focusNode: _focusEmail,
                                    enabled: false,
                                    validator: (value) =>
                                        Validator.validateEmail(
                                      email: value,
                                    ),
                                    style: signTextFormField,
                                    decoration: CommonStyle.textFieldStyle(
                                      labelTextStr: "Adres Email",
                                    ),
                                    onChanged: (String? value) {
                                      _formKey.currentState!.validate();
                                    },
                                  ),
                                  const SizedBox(height: 5.0),
                                  _currentUser!.emailVerified
                                      ? const Text(
                                          'Email Zweryfikowany',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  _scaffoldKey.currentState!
                                                      // ignore: deprecated_member_use
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      elevation: 6.0,
                                                      backgroundColor:
                                                          primaryColor,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      content: Text(
                                                        'Sprawdź swoją pocztę, następnie odśwież tą stronę',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Nunito',
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                  await _currentUser!
                                                      .sendEmailVerification();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: primaryColor,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5.0,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Zweryfikuj Email',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _ischanged
                      ? () async {
                          if (_nameTextController.text !=
                              _currentUser?.displayName) {
                            _currentUser
                                ?.updateDisplayName(_nameTextController.text);
                            ref.child('users/' + _currentUser!.uid).set({
                              'nameID': name,
                              'name': _nameTextController.text,
                            });
                          } else if (_image != null) {
                            await uploadFile();
                          }

                          refresh();

                          _scaffoldKey.currentState!
                              // ignore: deprecated_member_use
                              .showSnackBar(
                            const SnackBar(
                              elevation: 6.0,
                              backgroundColor: primaryColor,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Zastosowano zmiany',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Nunito',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Zastosuj',
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
