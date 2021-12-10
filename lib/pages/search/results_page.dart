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

//Widgets

class ResultsPage extends StatelessWidget {
  final ValueChanged result;
  final String categoryName;
  const ResultsPage(
      {Key? key, required this.result, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          child: Column(
            children: [
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
                      result(0);
                    },
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "${categoryName[0].toUpperCase()}${categoryName.substring(1)}",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: documentsText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // ignore: dead_code
              _isEmpty ? GeneralWidgets.line() : const SizedBox(),
            ],
          ),
        ),
        Expanded(
          child: _isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints:
                          const BoxConstraints(maxWidth: 230, maxHeight: 220),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.liquor_outlined,
                            size: 85,
                            color: halfBlackColor,
                          ),
                          const Text(
                            'Trochę tu pusto',
                            style: pageNameSign,
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'Utwórz własny poradnik wykorzystując ten przedmiot',
                            style: postSmallName,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 7.0,
                                    ),
                                  ),
                                  child: const Text(
                                    'Utwórz Poradnik',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
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
                )
              // ignore: dead_code
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PostPage(),
                              ),
                            );
                          },
                          onProfilePhoto: () {
                            print("Profile");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
