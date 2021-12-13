//Plugins
import 'package:auth/pages/post/comments_overlay.dart';
import 'package:auth/pages/post_page.dart';
import 'package:auth/pages/public_profile_page.dart';
import 'package:auth/theme/colors.dart';
import 'package:auth/theme/text.dart';
import 'package:auth/widgets/general_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//Firebase Package
//Pages
//Utils
//Theme

//Widgets

class ResultsPage extends StatelessWidget {
  final ValueChanged result;
  final String categoryName;
  List needs;
  ResultsPage(
      {Key? key,
      required this.result,
      required this.categoryName,
      required this.needs})
      : super(key: key);

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
              needs.isEmpty ? GeneralWidgets.line() : const SizedBox(),
            ],
          ),
        ),
        Expanded(
          child: needs.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.liquor_outlined,
                            size: 85,
                            color: halfBlackColor,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Trochę tu pusto',
                            style: pageNameSign,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Utwórz własny poradnik wykorzystując ten przedmiot',
                            style: postSmallName,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
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
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: needs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FutureBuilder(
                                  future: Future.wait([
                                    downloadProfilePhoto(needs[index]['id']),
                                    downloadProfileUserPhoto(
                                        needs[index]['authorID'])
                                  ]),
                                  builder: (context,
                                      AsyncSnapshot<List<dynamic>> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return GeneralWidgets.post(
                                        postTitle: needs[index]['title'],
                                        profilePhotoUrl: snapshot.data![1],
                                        postMainPhotoUrl: snapshot.data![0],
                                        postLikes: needs[index]['likes'] ?? '0',
                                        postComents:
                                            needs[index]['comments'] ?? '0',
                                        isLiked: false,
                                        onLiked: () {},
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
                                              builder: (context) => PostPage(
                                                  postID: needs[index]['id']),
                                            ),
                                          );
                                        },
                                        onProfilePhoto: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PublicProfilePage(
                                                      userID: needs[index]
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
        ),
      ],
    );
  }
}
