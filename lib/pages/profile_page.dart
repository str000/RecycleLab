//Plugins
import 'package:auth/pages/profile/liked_page.dart';
import 'package:auth/pages/profile/tutorials_list_page.dart';
import 'package:auth/pages/settings/account_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/utils/fire_auth.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:auth/widgets/top_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//Firebase Package
//Pages
//Utils
//Theme
import 'package:snapping_sheet/snapping_sheet.dart';

//Widgets

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseDatabase.instance.reference();

  String userName = 'Nazwa';
  String userID = '@NazwaID';
  String profileImageURL = '';
  var _image;
  var imagePicker;
  bool imageSending = false;

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
    downloadProfilePhoto();
    userName = _currentUser!.displayName!;
    ref.child('users/' + _currentUser!.uid + '/nameID').once().then((value) {
      userID = '@' + value.value;
    });
    super.initState();
  }

  Future<void> refresh() async {
    User? user = await FireAuth.refreshUser(_currentUser!);

    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
    userName = _currentUser!.displayName!;
  }

  final ScrollController _myScrollController = ScrollController();
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 60,
            child: SnappingSheet(
              lockOverflowDrag: true,
              snappingPositions: [
                const SnappingPosition.pixels(
                  positionPixels: 130,
                  snappingCurve: Curves.easeOutExpo,
                  snappingDuration: Duration(seconds: 1),
                  grabbingContentOffset: GrabbingContentOffset.top,
                ),
                SnappingPosition.pixels(
                  positionPixels: MediaQuery.of(context).size.height - 150,
                  snappingCurve: Curves.easeOutExpo,
                  snappingDuration: const Duration(seconds: 1),
                  grabbingContentOffset: GrabbingContentOffset.bottom,
                ),
              ],
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Stack(
                    children: [
                      _image != null
                          ? Image.file(
                              _image,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 200,
                              fit: BoxFit.cover,
                            )
                          : profileImageURL != ''
                              ? Image.network(
                                  profileImageURL,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                      const TopBar(
                        height: 70,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 290, left: 10),
                    child: _image != null
                        ? SizedBox(
                            height: 50,
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GeneralWidgets.actionButton(
                                  backgroundColor: quarterBlackcolor,
                                  icon: imageSending
                                      ? SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  CircularProgressIndicator(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : const Icon(
                                          Icons.done_rounded,
                                          color: Color.fromRGBO(1, 124, 13, 1),
                                          size: 30,
                                        ),
                                  onClick: () async {
                                    setState(() {
                                      imageSending = true;
                                    });
                                    await uploadFile();
                                    setState(() {
                                      profileImageURL = '';
                                      _image = null;
                                      imageSending = false;
                                    });
                                    downloadProfilePhoto();
                                  },
                                ),
                                GeneralWidgets.actionButton(
                                  backgroundColor: quarterBlackcolor,
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                    color: likeColor,
                                    size: 30,
                                  ),
                                  onClick: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        : GeneralWidgets.actionButton(
                            backgroundColor: quarterBlackcolor,
                            icon: const Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            onClick: () async {
                              XFile image = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                _image = File(image.path);
                              });
                            },
                          ),
                  ),
                ],
              ),
              grabbingHeight: 140,
              grabbing: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 75,
                          decoration: const BoxDecoration(
                            color: quarterBlackcolor,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          margin: const EdgeInsets.all(10),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    userID,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: halfBlackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              GeneralWidgets.actionButton(
                                backgroundColor: contrastWhite,
                                icon: const Icon(
                                  Icons.manage_accounts_rounded,
                                  color: halfBlackColor,
                                  size: 30,
                                ),
                                onClick: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const AccountPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GeneralWidgets.line(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              sheetBelow: SnappingSheetContent(
                childScrollController: _myScrollController,
                draggable: true,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    controller: _myScrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 220),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    GeneralWidgets.actionButton(
                                      backgroundColor: contrastWhite,
                                      icon: const Icon(
                                        Icons.receipt_rounded,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                      onClick: () {},
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      '21',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GeneralWidgets.actionButton(
                                      backgroundColor: contrastWhite,
                                      icon: const Icon(
                                        Icons.favorite_rounded,
                                        color: likeColor,
                                        size: 30,
                                      ),
                                      onClick: () {},
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      '20 tys.',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: likeColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GeneralWidgets.actionButton(
                                      backgroundColor: contrastWhite,
                                      icon: const Icon(
                                        Icons.star_rounded,
                                        color: Color.fromRGBO(251, 188, 5, 1),
                                        size: 35,
                                      ),
                                      onClick: () {},
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      '4.5',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(251, 188, 5, 1),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GeneralWidgets.line(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Nunito",
                                  ),
                                  primary: currentIndex == 0
                                      ? Colors.black
                                      : halfBlackColor,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      currentIndex = 0;
                                    },
                                  );
                                },
                                child: const Text("Instrukcje"),
                              ),
                              const SizedBox(width: 20),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Nunito",
                                  ),
                                  primary: currentIndex == 1
                                      ? Colors.black
                                      : halfBlackColor,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      currentIndex = 1;
                                    },
                                  );
                                },
                                child: const Text("Polubione"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 340,
                            child: IndexedStack(
                              children: const <Widget>[
                                TutorialsPage(),
                                LikedPage(),
                              ],
                              index: currentIndex,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
