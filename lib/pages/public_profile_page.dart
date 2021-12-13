//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme
import 'package:snapping_sheet/snapping_sheet.dart';

//Widgets

class PublicProfilePage extends StatefulWidget {
  const PublicProfilePage({Key? key}) : super(key: key);

  @override
  _PublicProfilePageState createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
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
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
                      ),
                    ),
                  ),
                ),
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
                          children: const [
                            Text(
                              'Dominika Kowalska',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '@dominikakowalska',
                              style: TextStyle(
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
                            GeneralWidgets.post(
                              postTitle: "Poduszka z folii",
                              profilePhotoUrl:
                                  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
                              postMainPhotoUrl:
                                  "https://images.unsplash.com/photo-1520899981500-21af7ff24c2a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1077&q=80",
                              postLikes: "205",
                              postComents: "25",
                              isLiked: true,
                              onLiked: () {
                                print('Like');
                              },
                              onComment: () {
                                Navigator.of(context).push(CommentsOverlay());
                              },
                              onShared: () {
                                print("Share");
                              },
                              onPhoto: () {
                                /*Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PostPage(),
                                  ),
                                );*/
                              },
                              onProfilePhoto: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PublicProfilePage(),
                                  ),
                                );
                              },
                            ),
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
