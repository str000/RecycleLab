//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme
import 'package:snapping_sheet/snapping_sheet.dart';

//Widgets

class PublicProfilePage extends StatefulWidget {
  String userID;
  PublicProfilePage({Key? key, required this.userID}) : super(key: key);

  @override
  _PublicProfilePageState createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  final ref = FirebaseDatabase.instance.reference();
  List _user = [];
  List _needs = [];

  @override
  void initState() {
    super.initState();
    ref.child('users/' + widget.userID).onValue.listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      List needs = [];

      needs.add(values);

      setState(() {
        _user = needs;
      });
    });
    ref.child('posts').onValue.listen((event) async {
      Map<dynamic, dynamic> values = event.snapshot.value;
      List needs = [];
      values.forEach((key, values) {
        values['id'] = key;

        if (values['public'] == true && values['authorID'] == widget.userID) {
          needs.add(values);
        }
      });
      setState(() {
        _needs = needs;
      });
    });
  }

  Future<String> downloadProfileUserPhoto(String authorID) async {
    final ref = FirebaseStorage.instance
        .ref('users/' + authorID + '/profile-photo.png');
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<String> downloadProfilePhoto(String postID) async {
    final ref = FirebaseStorage.instance.ref('posts/' + postID + '/photo0');
    var url = await ref.getDownloadURL();
    return url.toString();
  }

  var currentIndex = 0;
  final ScrollController _myScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnappingSheet(
        lockOverflowDrag: true,
        snappingPositions: const [
          SnappingPosition.pixels(
            positionPixels: 130,
            snappingCurve: Curves.easeOutExpo,
            snappingDuration: Duration(seconds: 1),
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
          SnappingPosition.factor(
            positionFactor: 1.0,
            snappingCurve: Curves.easeOutExpo,
            snappingDuration: Duration(seconds: 1),
            grabbingContentOffset: GrabbingContentOffset.bottom,
          ),
        ],
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Stack(
              children: [
                FutureBuilder(
                    future:
                        Future.wait([downloadProfileUserPhoto(widget.userID)]),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data![0],
                              ),
                            ),
                          ),
                        );
                      }
                      return Container(
                        color: Colors.white,
                      );
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: GeneralWidgets.actionButton(
                backgroundColor: quarterBlackcolor,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: halfBlackColor,
                  size: 30,
                ),
                onClick: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        grabbingHeight: 140,
        grabbing: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
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
                              _user[0]['name'],
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '@' + _user[0]['nameID'],
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
                            Icons.person_add_rounded,
                            color: halfBlackColor,
                            size: 30,
                          ),
                          onClick: () {},
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
                              Text(
                                _needs.length.toString(),
                                style: const TextStyle(
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
                                '0',
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
                                '0',
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
                      children: const [
                        Text(
                          "Instrukcje",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                            color: halfBlackColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 190,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _needs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FutureBuilder(
                                      future: Future.wait([
                                        downloadProfilePhoto(
                                            _needs[index]['id']),
                                        downloadProfileUserPhoto(widget.userID)
                                      ]),
                                      builder: (context,
                                          AsyncSnapshot<List<dynamic>>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return GeneralWidgets.post(
                                            postTitle: _needs[index]['title'],
                                            profilePhotoUrl: snapshot.data![1],
                                            postMainPhotoUrl: snapshot.data![0],
                                            postLikes:
                                                _needs[index]['likes'] ?? '0',
                                            postComents: _needs[index]
                                                    ['comments'] ??
                                                '0',
                                            isLiked: false,
                                            onLiked: () {
                                              print('Like');
                                            },
                                            onComment: () {
                                              Navigator.of(context)
                                                  .push(CommentsOverlay());
                                            },
                                            onShared: () {
                                              print("Share");
                                            },
                                            onPhoto: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostPage(
                                                          postID: _needs[index]
                                                              ['id']),
                                                ),
                                              );
                                            },
                                            onProfilePhoto: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PublicProfilePage(
                                                          userID: _needs[index]
                                                              ['authorID']),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                        return Container(
                                          color: Colors.orange,
                                        );
                                      });
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
